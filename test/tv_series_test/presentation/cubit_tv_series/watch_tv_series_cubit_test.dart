import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/get_on_air_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/watch_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_tv/dummy_objects.dart';
import 'on_air_tv_series_cubit_test.mocks.dart';
import 'watch_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetWatchListStatus,GetWatchlistTvSeries,SaveWatchlist,RemoveWatchlist])
void main() {
  late WatchlistTvSeriesCubit watchlistTvSeriesCubit;
  late MockGetWatchListTvSeries mockGetWatchListTvSeries;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    mockGetWatchListTvSeries = MockGetWatchListTvSeries();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistTvSeriesCubit = WatchlistTvSeriesCubit(
        mockGetWatchListTvSeries,
        mockGetWatchlistStatus,
        mockSaveWatchlist,
        mockRemoveWatchlist
    );
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];
  String message = '';
  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should get the watchlist status is saved',
    build: () {
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.loadWatchlistStatus(tId),
    expect: () =>
    [
      TvAddWatchlistState(true),

    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(tId));
    },
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should get the watchlist status is not saved',
    build: () {
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => false);
      return watchlistTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.loadWatchlistStatus(tId),
    expect: () =>
    [
      TvAddWatchlistState(false),

    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(tId));
    },
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should update watchlist message when add watchlist failed',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      return watchlistTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.addWatchlist(testTvDetail),
    expect: () =>
    [
      TvAddWatchlistState(false),


    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(tId));
    },
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should update watchlist message when add watchlist succes',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.addWatchlist(testTvDetail),
    expect: () =>
    [
      TvAddWatchlistState(true),


    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(testTvDetail.id));
    },
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right("Remove"));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      return watchlistTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.removeFromWatchlist(testTvDetail),
    expect: () =>
    [
      TvAddWatchlistState(false),


    ],
    verify: (cubit) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should execute save watchlist when function called',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right("Succes"));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.addWatchlist(testTvDetail),
    expect: () =>
    [
      TvAddWatchlistState(true),


    ],
    verify: (cubit) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );
}