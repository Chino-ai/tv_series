import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_series_genre.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/watch_tv_series_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../cubit_tv_series/tv_series_detail_cubit.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_detail';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailCubit>()
          .fetchTvDetail(widget.id);
      context.read<WatchlistTvSeriesCubit>()
          .loadWatchlistStatus(widget.id);
      context.read<TvRecommendationCubit>()
          .fetchTvRecommendation(widget.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
        builder: (context, provider) {
          if (provider is TvSeriesDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider is TvSeriesDetailHasData) {
            final tv = provider.result;
            return SafeArea(
              child: DetailContent(
                tv,

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
  final TvSeriesDetail tvDetail;


  DetailContent(this.tvDetail);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
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
                              tvDetail.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
                             builder: (context, state) {
                               if(state is TvAddWatchlistState) {
                                 return ElevatedButton(
                                   onPressed: () async {
                                     if (!state.isAddedToWatchlist) {
                                       await context.read<WatchlistTvSeriesCubit>()
                                           .addWatchlist(tvDetail);
                                     } else {
                                       await context.read<WatchlistTvSeriesCubit>()
                                           .removeFromWatchlist(tvDetail);
                                     }

                                     final message =
                                         context
                                             .read<WatchlistTvSeriesCubit>()
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
                              _showGenres(tvDetail.genre),
                            ),
                            /*Text(
                              _showDuration(tvDetail.),
                            ),*/
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            TvRecom(),
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



  String _showGenres(List<TvSeriesGenre> genres) {
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

class TvRecom extends StatelessWidget {
  const TvRecom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvRecommendationCubit, TvRecommendationState>(
      builder: (context, data) {
        if (data is TvRecommendationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data is TvRecommendationError) {
          return Text(data.message);
        } else if (data is TvRecommendationHasData) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = data.result[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TvSeriesDetailPage.ROUTE_NAME,
                        arguments: tv.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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

