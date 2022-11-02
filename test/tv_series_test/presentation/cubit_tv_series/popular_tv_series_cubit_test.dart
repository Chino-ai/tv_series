import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/presentation/cubit_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/popular_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesCubit popularTvSeriesCubit;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesCubit = PopularTvSeriesCubit(mockGetPopularTvSeries);
  });

  test('initial state should be empty', () {
    expect(popularTvSeriesCubit.state, PopularTvSeriesEmpty());
  });

  final tTvModel = TvSeries(
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
  final tTvList = <TvSeries>[tTvModel];

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'Should emit [Loading, HasData] when data of popular movies is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      return popularTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.fetchPopularTv(),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvList),
    ],
    verify: (cubit) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'Should emit [Loading, Error] when get get popular movies is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.fetchPopularTv(),
    expect: () => [
      PopularTvSeriesLoading(),
      const PopularTvSeriesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
