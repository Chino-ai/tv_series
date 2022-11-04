import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_series.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'search_tv_series_cubit_test.mocks.dart';


@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchCubit tvSeriesSearchCubit;
  late MockGetSeacrhTvSeries mockGetSeacrhTvSeries;

  setUp(() {
    mockGetSeacrhTvSeries = MockGetSeacrhTvSeries();
    tvSeriesSearchCubit = TvSeriesSearchCubit(mockGetSeacrhTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvSeriesSearchCubit.state,TvSeriesSearchEmpty());
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
  final tQuery = 'House of the Dragon';
  blocTest<TvSeriesSearchCubit, TvSeriesSearchState>(
    'Should emit [Loading, HasData] when data of search tv is gotten successfully',
    build: () {
      when(mockGetSeacrhTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return tvSeriesSearchCubit;
    },
    act: (blocCubit) => blocCubit.fetchTvSearch(tQuery),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(tTvList),
    ],
    verify: (cubit) {
      verify(mockGetSeacrhTvSeries.execute(tQuery));
    },
  );

  blocTest<TvSeriesSearchCubit, TvSeriesSearchState>(
    'Should emit [Loading, Error] when search tv  is unsuccessful',
    build: () {
      when(mockGetSeacrhTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSearchCubit;
    },
    act: (blocCubit) => blocCubit.fetchTvSearch(tQuery),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetSeacrhTvSeries.execute(tQuery));
    },
  );
}
