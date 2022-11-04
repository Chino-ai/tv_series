import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_series.dart';
import 'package:ditonton/presentation/cubit_movie/movies_detail_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_tv/dummy_objects.dart';
import 'tv_series_detail_cubit_test.mocks.dart';
import 'popular_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetTvDetailSeries])
void main() {
  late TvSeriesDetailCubit tvSeriesDetailCubit;
  late MockGetDetailTvSeries mockGetDetailTvSeries;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    tvSeriesDetailCubit = TvSeriesDetailCubit(mockGetDetailTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvSeriesDetailCubit.state, TvSeriesDetailEmpty());
  });

  const ids = 1;

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data of tv detail is gotten successfully',
    build: () {
      when(mockGetDetailTvSeries.execute(ids))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvSeriesDetailCubit;
    },
    act: (blocCubit) => blocCubit.fetchTvDetail(ids),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailHasData(testTvDetail),
    ],
    verify: (cubit) {
      verify(mockGetDetailTvSeries.execute(ids));
    },
  );

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should emit [Loading, Error] when get tv detail is unsuccessful',
    build: () {
      when(mockGetDetailTvSeries.execute(ids))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailCubit;
    },
    act: (blocCubit) => blocCubit.fetchTvDetail(ids),
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetDetailTvSeries.execute(ids));
    },
  );


}
