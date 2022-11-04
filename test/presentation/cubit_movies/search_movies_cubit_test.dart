import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/presentation/cubit_movie/movies_search_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_movies_cubit_test.mocks.dart';


@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchCubit moviesSearchCubit;
  late MockGetSeacrhMovies mockGetSeacrhMovies;

  setUp(() {
    mockGetSeacrhMovies = MockGetSeacrhMovies();
    moviesSearchCubit = MoviesSearchCubit(mockGetSeacrhMovies);
  });

  test('initial state should be empty', () {
    expect(moviesSearchCubit.state,MoviesSearchEmpty());
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
  final tQuery = 'spiderman';
  blocTest<MoviesSearchCubit, MoviesSearchState>(
    'Should emit [Loading, HasData] when data of seacrh movies is gotten successfully',
    build: () {
      when(mockGetSeacrhMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return moviesSearchCubit;
    },
    act: (blocCubit) => blocCubit.fetchMovieSearch(tQuery),
    expect: () => [
      MoviesSearchLoading(),
      MoviesSearchHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetSeacrhMovies.execute(tQuery));
    },
  );

  blocTest<MoviesSearchCubit, MoviesSearchState>(
    'Should emit [Loading, Error] when get seacrh movies is unsuccessful',
    build: () {
      when(mockGetSeacrhMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesSearchCubit;
    },
    act: (blocCubit) => blocCubit.fetchMovieSearch(tQuery),
    expect: () => [
      MoviesSearchLoading(),
      const MoviesSearchError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetSeacrhMovies.execute(tQuery));
    },
  );
}
