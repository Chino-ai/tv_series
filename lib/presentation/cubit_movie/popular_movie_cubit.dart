import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
part 'popular_movie_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesCubit(this._getPopularMovies)
      : super(PopularMoviesEmpty());

  Future<void> fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await _getPopularMovies.execute();

    result.fold(
          (failure) {
        emit(PopularMoviesError(failure.message));
      },
          (tvData) {
        emit(PopularMoviesHasData(tvData));
      },
    );
  }


}
