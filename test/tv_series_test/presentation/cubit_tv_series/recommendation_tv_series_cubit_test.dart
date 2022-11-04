import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_series_recommendation.dart';
import 'package:ditonton/presentation/cubit_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_recommendation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recommendation_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvRecommendationCubit tvRecommendationCubit;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvRecommendationCubit = TvRecommendationCubit(mockGetTvSeriesRecommendations);
  });

  test('initial state should be empty', () {
    expect(tvRecommendationCubit.state, TvRecommendationEmpty());
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
  const id =1;

  blocTest<TvRecommendationCubit, TvRecommendationState>(
    'Should emit [Loading, HasData] when data of tv recommendation is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(id))
          .thenAnswer((_) async => Right(tTvList));
      return tvRecommendationCubit;
    },
    act: (blocCubit) => blocCubit.fetchTvRecommendation(id),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationHasData(tTvList),
    ],
    verify: (cubit) {
      verify(mockGetTvSeriesRecommendations.execute(id));
    },
  );

  blocTest<TvRecommendationCubit, TvRecommendationState>(
    'Should emit [Loading, Error] when tv recommendation is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationCubit;
    },
    act: (blocCubit) => blocCubit.fetchTvRecommendation(id),
    expect: () => [
      TvRecommendationLoading(),
      const TvRecommendationError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTvSeriesRecommendations.execute(id));
    },
  );
}
