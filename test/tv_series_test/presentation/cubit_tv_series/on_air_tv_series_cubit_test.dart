import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_on_air_tv_series.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_air_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetOnAirTvSeries])
void main() {
  late OnAirTvSeriesCubit onAirTvSeriesCubit;
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;

  setUp(() {
    mockGetOnAirTvSeries = MockGetOnAirTvSeries();
    onAirTvSeriesCubit = OnAirTvSeriesCubit(mockGetOnAirTvSeries);
  });

  test('initial state should be empty', () {
    expect(onAirTvSeriesCubit.state, OnAirTvSeriesEmpty());
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

  blocTest<OnAirTvSeriesCubit, OnAirTvSeriesState>(
    'Should emit [Loading, HasData] when data of on air tv is gotten successfully',
    build: () {
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      return onAirTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.fetchOnAirTv(),
    expect: () => [
      OnAirTvSeriesLoading(),
      OnAirTvSeriesHasData(tTvList),
    ],
    verify: (cubit) {
      verify(mockGetOnAirTvSeries.execute());
    },
  );

  blocTest<OnAirTvSeriesCubit, OnAirTvSeriesState>(
    'Should emit [Loading, Error] when get on air tv is unsuccessful',
    build: () {
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onAirTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.fetchOnAirTv(),
    expect: () => [
      OnAirTvSeriesLoading(),
      const OnAirTvSeriesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetOnAirTvSeries.execute());
    },
  );
}
