import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_on_air_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTvSeries = MockGetOnAirTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getOnAirTv: mockGetOnAirTvSeries,
      getPopularTv: mockGetPopularTvSeries,
      getTopRatedTv: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    voteAverage: 1.0,
    voteCount: 1,
    name: 'name',
  );
  final tTvList = <TvSeries>[tTv];

  group('now playing tv', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchNowPlayingTv();
      // assert
      verify(mockGetOnAirTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loading);
    });

    test('should change tv data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
