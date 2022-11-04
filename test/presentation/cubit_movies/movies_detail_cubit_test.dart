import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton/presentation/cubit_movie/movies_detail_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movies_detail_cubit_test.mocks.dart';



@GenerateMocks([GetMovieDetail])
void main() {
  late MoviesDetailCubit moviesDetailCubit;
  late MockGetDetailMovie mockGetDetailMovie;

  setUp(() {
    mockGetDetailMovie = MockGetDetailMovie();
    moviesDetailCubit = MoviesDetailCubit(mockGetDetailMovie);
  });

  test('initial state should be empty', () {
    expect(moviesDetailCubit.state, MoviesDetailEmpty());
  });

  const ids = 1;

  blocTest<MoviesDetailCubit, MoviesDetailState>(
    'Should emit [Loading, HasData] when data of detail movies is gotten successfully',
    build: () {
      when(mockGetDetailMovie.execute(ids))
          .thenAnswer((_) async => Right(testMovieDetail));
      return moviesDetailCubit;
    },
    act: (blocCubit) => blocCubit.fetchMoviesDetail(ids),
    expect: () => [
      MoviesDetailLoading(),
      MoviesDetailHasData(testMovieDetail),
    ],
    verify: (cubit) {
      verify(mockGetDetailMovie.execute(ids));
    },
  );

  blocTest<MoviesDetailCubit, MoviesDetailState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetDetailMovie.execute(ids))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesDetailCubit;
    },
    act: (blocCubit) => blocCubit.fetchMoviesDetail(ids),
    expect: () => [
      MoviesDetailLoading(),
      const MoviesDetailError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetDetailMovie.execute(ids));
    },
  );


}
