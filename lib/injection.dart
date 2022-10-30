import 'package:ditonton/data/datasources/db/movies/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/db/tv/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/db/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/tv_series_remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
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
import 'package:ditonton/presentation/cubit_tv_series/tv_series_list_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_search_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/watch_tv_series_cubit.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv/on_air_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv/watch_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'data/datasources/db/movies/database_helper.dart';
import 'data/datasources/db/movies/movie_local_data_source.dart';
import 'data/datasources/db/tv/database_helper.dart';
import 'domain/usecases/movies/get_movie_detail.dart';
import 'domain/usecases/movies/get_movie_recommendations.dart';
import 'domain/usecases/movies/get_now_playing_movies.dart';
import 'domain/usecases/movies/get_popular_movies.dart';
import 'domain/usecases/movies/get_top_rated_movies.dart';
import 'domain/usecases/movies/get_watchlist_movies.dart';
import 'domain/usecases/movies/get_watchlist_status.dart';
import 'domain/usecases/movies/remove_watchlist.dart';
import 'domain/usecases/movies/save_watchlist.dart';
import 'domain/usecases/tv/get_on_air_tv_series.dart';
import 'domain/usecases/tv/get_popular_tv_series.dart';
import 'domain/usecases/tv/get_top_rated_tv_series.dart';
import 'domain/usecases/tv/get_tv_detail_series.dart';
import 'domain/usecases/tv/get_tv_series_recommendation.dart';
import 'domain/usecases/tv/get_watchlist_status.dart';
import 'domain/usecases/tv/get_watchlist_tv_series.dart';
import 'domain/usecases/tv/search_tv_series.dart';


final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
        () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
        () => OnAirTvSeriesNotifier(
      getOnAirTv: locator(),
    ),
  );

  locator.registerFactory(
        () => PopularTvSeriesNotifier(
        locator()
    ),
  );

  locator.registerFactory(
        () => TopRatedTvSeriesNotifier(
        getTopRatedTv: locator()

    ),
  );

  locator.registerFactory(
        () => TvSeriesDetailNotifier(
        getTvDetail: locator(),
        getTvRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator()

    ),
  );

  locator.registerFactory(
        () => TvSeriesListNotifier(
        getOnAirTv: locator(),
        getPopularTv: locator(),
        getTopRatedTv: locator()

    ),
  );

  locator.registerFactory(
        () => TvSeriesSearchNotifier(searchTv: locator()


    ),
  );

  locator.registerFactory(
        () => WatchlistTvSeriesNotifier(getWatchlistTv: locator()


    ),
  );



  locator.registerFactory(
        () => MoviesRecommendationCubit(
      locator(),

    ),
  );

  locator.registerFactory(
    () => MoviesListCubit(
      locator(),

    ),
  );
  locator.registerFactory(
    () => MoviesDetailCubit(
        locator(),



    ),
  );
  locator.registerFactory(
    () => MoviesSearchCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(
     locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesCubit(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
        () => OnAirTvSeriesCubit(
      locator(),
    ),
  );

  locator.registerFactory(
        () => PopularTvSeriesCubit(
     locator()
    ),
  );

  locator.registerFactory(
        () => TopRatedTvSeriesCubit(
            locator()

    ),
  );

  locator.registerFactory(
        () => TvSeriesDetailCubit(
            locator(),


    ),
  );

  locator.registerFactory(
        () => TvSeriesListCubit(
          locator(),

    ),
  );

  locator.registerFactory(
        () => TvSeriesSearchCubit(locator()


    ),
  );

  locator.registerFactory(
        () => TvRecommendationCubit(locator()


    ),
  );

  locator.registerFactory(
        () => WatchlistTvSeriesCubit(locator(),locator(),locator(),locator()


    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => TvSeriesRemoveWatchlist(locator()) );
  locator.registerLazySingleton(() => TvSeriesSaveWatchlist(locator()));
  locator.registerLazySingleton(() => GetOnAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvDetailSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );


  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(remoteDataSource: locator(), localDataSource: locator()

    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(tvdatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
