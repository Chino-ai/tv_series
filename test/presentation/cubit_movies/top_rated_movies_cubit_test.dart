import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/presentation/cubit_movie/top_rated_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'top_rated_movies_cubit_test.mocks.dart';


@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesCubit topRatedMoviesCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesCubit = TopRatedMoviesCubit(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(topRatedMoviesCubit.state, TopRatedMoviesEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
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

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'Should emit [Loading, HasData] when data of top rated movies is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMoviesCubit;
    },
    act: (blocCubit) => blocCubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'Should emit [Loading, Error] when get get top rated movies is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMoviesCubit;
    },
    act: (blocCubit) => blocCubit.fetchTopRatedMovies(),
    expect: () => [
  TopRatedMoviesLoading(),
      const TopRatedMoviesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
