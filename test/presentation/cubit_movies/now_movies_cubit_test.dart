import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/presentation/cubit_movie/movies_list_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/popular_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_movies_cubit_test.mocks.dart';
import 'popular_movies_cubit_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MoviesListCubit moviesListCubit;
  late MockGetNowMovies mockGetNowMovies;

  setUp(() {
    mockGetNowMovies = MockGetNowMovies();
    moviesListCubit = MoviesListCubit(mockGetNowMovies);
  });

  test('initial state should be empty', () {
    expect(moviesListCubit.state, MoviesListEmpty());
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

  blocTest<MoviesListCubit, MoviesListState>(
    'Should emit [Loading, HasData] when data of now movies is gotten successfully',
    build: () {
      when(mockGetNowMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return moviesListCubit;
    },
    act: (blocCubit) => blocCubit.fetchNowPlayingMovies(),
    expect: () => [
      MoviesListLoading(),
      MoviesListHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetNowMovies.execute());
    },
  );

  blocTest<MoviesListCubit, MoviesListState>(
    'Should emit [Loading, Error] when get now movies is unsuccessful',
    build: () {
      when(mockGetNowMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesListCubit;
    },
    act: (blocCubit) => blocCubit.fetchNowPlayingMovies(),
    expect: () => [
      MoviesListLoading(),
      const MoviesListError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetNowMovies.execute());
    },
  );
}
