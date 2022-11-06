import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton/presentation/cubit_movie/watchlist_movie_cubit.dart';


import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../tv_series_test/dummy_data_tv/dummy_objects.dart';
import 'watch_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetWatchListStatus,GetWatchListStatus,SaveWatchlist,RemoveWatchlist])
void main() {
  late WatchlistMoviesCubit watchlistMoviesCubit;
  late MockGetWatchListTvSeries mockGetWatchListTvSeries;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;


  setUp(() {
    mockGetWatchListTvSeries = MockGetWatchListTvSeries();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMoviesCubit = WatchlistMoviesCubit(
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
  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should get the watchlist status is saved',
    build: () {
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistMoviesCubit;
    },
    act: (blocCubit) => blocCubit.loadWatchlistStatus(tId),
    expect: () =>
    [
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(true),

    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(tId));
    },
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should get the watchlist status is not saved',
    build: () {
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => false);
      return watchlistMoviesCubit;
    },
    act: (blocCubit) => blocCubit.loadWatchlistStatus(tId),
    expect: () =>
    [
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(false),

    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(tId));
    },
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should update watchlist message when add watchlist failed',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return watchlistMoviesCubit;
    },
    act: (blocCubit) => blocCubit.addWatchlist(testMovieDetail),
    expect: () =>
    [
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(false),
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(false),


    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(tId));
    },
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should update watchlist message when add watchlist succes',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return watchlistMoviesCubit;
    },
    act: (blocCubit) => blocCubit.addWatchlist(testMovieDetail),
    expect: () =>
    [
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(true),
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(true),


    ],
    verify: (cubit) {
      verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
    },
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right("Remove"));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return watchlistMoviesCubit;
    },
    act: (blocCubit) => blocCubit.removesWatchlist(testMovieDetail),
    expect: () =>
    [
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(false),
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(false),


    ],
    verify: (cubit) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should execute save watchlist when function called',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right("Succes"));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return watchlistMoviesCubit;
    },
    act: (blocCubit) => blocCubit.addWatchlist(testMovieDetail),
    expect: () =>
    [
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(true),
      WatchlistMoviesLoading(),
      MovieAddWatchlistState(true),


    ],
    verify: (cubit) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );
}