import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/presentation/cubit_movie/movies_recommendation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recommendation_tv_series_cubit_test.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main() {
  late MoviesRecommendationCubit moviesRecommendationCubit;
  late MockGetMoviesRecommendations mockGetMoviesRecommendations;

  setUp(() {
    mockGetMoviesRecommendations = MockGetMoviesRecommendations();
    moviesRecommendationCubit = MoviesRecommendationCubit(mockGetMoviesRecommendations);
  });

  test('initial state should be empty', () {
    expect(moviesRecommendationCubit.state, MoviesRecommendationEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const id =557;

  blocTest<MoviesRecommendationCubit, MoviesRecommendationState>(
    'Should emit [Loading, HasData] when data of recommendation movies is gotten successfully',
    build: () {
      when(mockGetMoviesRecommendations.execute(id))
          .thenAnswer((_) async => Right(tMovieList));
      return moviesRecommendationCubit;
    },
    act: (blocCubit) => blocCubit.fetchMovieRecommendation(id),
    expect: () => [
      MoviesRecommendationLoading(),
      MoviesRecommendationHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetMoviesRecommendations.execute(id));
    },
  );

  blocTest<MoviesRecommendationCubit, MoviesRecommendationState>(
    'Should emit [Loading, Error] when get recommendation movies is unsuccessful',
    build: () {
      when(mockGetMoviesRecommendations.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesRecommendationCubit;
    },
    act: (blocCubit) => blocCubit.fetchMovieRecommendation(id),
    expect: () => [
      MoviesRecommendationLoading(),
      const MoviesRecommendationError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetMoviesRecommendations.execute(id));
    },
  );
}
