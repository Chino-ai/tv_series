import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/cubit_tv_series/top_rated_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'top_rated_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesCubit topRatedTvSeriesCubit;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesCubit = TopRatedTvSeriesCubit(mockGetTopRatedTvSeries);
  });

  test('initial state should be empty', () {
    expect(topRatedTvSeriesCubit.state, TopRatedTvSeriesEmpty());
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

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'Should emit [Loading, HasData] when data of top rated tv is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.fetchTopRatedTv(),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(tTvList),
    ],
    verify: (cubit) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'Should emit [Loading, Error] when top rated tv is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesCubit;
    },
    act: (blocCubit) => blocCubit.fetchTopRatedTv(),
    expect: () => [
      TopRatedTvSeriesLoading(),
      const TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
