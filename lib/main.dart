import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit_movie/movies_detail_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/movies_list_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/movies_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/movies_search_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_search_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/watch_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/movies/about_page.dart';
import 'package:ditonton/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/search_page.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv/on_air_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_series_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/ssl_pinning.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => di.locator<MoviesListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesRecommendationCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<MoviesDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<OnAirTvSeriesCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<TvSeriesSearchCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            case HomeTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeTvSeriesPage());

            case TvSeriesSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSeriesSearchPage());

            case OnAirTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnAirTvSeriesPage());

            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());

            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());

            case TvSeriesDetailPage.ROUTE_NAME:
              final ids = settings.arguments as int;
              return CupertinoPageRoute(builder: (_) => TvSeriesDetailPage(id: ids,));

            case WatchlistTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => WatchlistTvPage());
              

            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
