import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/cubit_movie/movies_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/watchlist_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../cubit_movie/movies_detail_cubit.dart';


class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviesDetailCubit>().fetchMoviesDetail(widget.id);
      context.read<WatchlistMoviesCubit>().loadWatchlistStatus(widget.id);
      context.read<MoviesRecommendationCubit>().fetchMovieRecommendation(widget.id);

    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: BlocBuilder<MoviesDetailCubit,MoviesDetailState>(
            builder: (context, provider) {
              if (provider is MoviesDetailLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider is MoviesDetailHasData) {
                final movie = provider.result;
                return SafeArea(
                  child: DetailContent(
                    movie,

                  ),
                );
              } else {
                return Text("Failed");
              }
            },
          ),
        );

  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
 

  DetailContent(this.movie);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: screenWidth,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              margin: const EdgeInsets.only(top: 48 + 8),
              child: DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kRichBlack,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 16,
                    ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: kHeading5,
                                    ),
                                    BlocBuilder<WatchlistMoviesCubit, WatchlistMoviesState>(
                                     builder: (context, state) {
                                       if(state is MovieAddWatchlistState) {
                                         return ElevatedButton(
                                           onPressed: () async {
                                             if (!state.isAddedToWatchlist) {
                                               await context.read<WatchlistMoviesCubit>()
                                                   .addWatchlist(movie);
                                             } else {
                                               await context.read<WatchlistMoviesCubit>()
                                                   .removesWatchlist(movie);
                                             }

                                             final message =
                                             await context.read<WatchlistMoviesCubit>()
                                                 .message;

                                             if (message ==
                                                 watchlistAddSuccessMessage ||
                                                 message ==
                                                     watchlistRemoveSuccessMessage) {
                                               ScaffoldMessenger.of(context)
                                                   .showSnackBar(
                                                   SnackBar(content: Text(message)));
                                             } else {
                                               showDialog(
                                                   context: context,
                                                   builder: (context) {
                                                     return AlertDialog(
                                                       content: Text(message),
                                                     );
                                                   });
                                             }
                                           },
                                           child: Row(
                                             mainAxisSize: MainAxisSize.min,
                                             children: [
                                               state.isAddedToWatchlist
                                                   ? Icon(Icons.check)
                                                   : Icon(Icons.add),
                                               Text('Watchlist'),
                                             ],
                                           ),
                                         );
                                       }else{
                                         return Container();
                                       }
                                      },
                                       ),
                                    Text(
                                      _showGenres(movie.genres),
                                    ),
                                    Text(
                                      _showDuration(movie.runtime),
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: movie.voteAverage / 2,
                                          itemCount: 5,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: kMikadoYellow,
                                          ),
                                          itemSize: 24,
                                        ),
                                        Text('${movie.voteAverage}')
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Overview',
                                      style: kHeading6,
                                    ),
                                    Text(
                                      movie.overview,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Recommendations',
                                      style: kHeading6,
                                    ),
                                    MovieRecom(),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                color: Colors.white,
                                height: 4,
                                width: 48,
                              ),
                            ),
                          ],
                        ),

                  );
                },
                // initialChildSize: 0.5,
                minChildSize: 0.25,
                // maxChildSize: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: kRichBlack,
                foregroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        );
  }


  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class MovieRecom extends StatelessWidget {
  const MovieRecom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesRecommendationCubit, MoviesRecommendationState>(
      builder: (context, data) {
        if (data is MoviesRecommendationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data is MoviesRecommendationError) {
          return Text(data.message);
        } else if (data is MoviesRecommendationHasData) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = data.result[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) =>
                            Center(
                              child:
                              CircularProgressIndicator(),
                            ),
                        errorWidget:
                            (context, url, error) =>
                            Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: data.result.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

