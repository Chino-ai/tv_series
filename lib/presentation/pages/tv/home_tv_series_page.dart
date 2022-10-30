import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/on_air_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/tv/tv_series.dart';
import '../movies/about_page.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home_tv';
  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
            () => context.read<OnAirTvSeriesCubit>().fetchOnAirTv());
                  context.read<PopularTvSeriesCubit>().fetchPopularTv();
                  context.read<TopRatedTvSeriesCubit>().fetchTopRatedTv();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Tv'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Movie Series'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSeriesSearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On Air Tv',
                onTap: () =>
                    Navigator.pushNamed(context, OnAirTvSeriesPage.ROUTE_NAME),
              ),

              BlocBuilder<OnAirTvSeriesCubit,OnAirTvSeriesState>(builder: (context, data) {

                if (data is OnAirTvSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is OnAirTvSeriesHasData) {
                  return TvList(data.result);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvSeriesCubit,PopularTvSeriesState>(builder: (context, data) {

                if (data is PopularTvSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is PopularTvSeriesHasData) {
                  return TvList(data.result);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvSeriesCubit,TopRatedTvSeriesState>(builder: (context, data) {
                if (data is TopRatedTvSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is TopRatedTvSeriesHasData) {
                  return TvList(data.result);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeries> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
