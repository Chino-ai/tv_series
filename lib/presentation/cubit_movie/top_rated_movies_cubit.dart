import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/movies/get_top_rated_movies.dart';
part 'top_rated_movies_state.dart';



class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesCubit(this._getTopRatedMovies)
      : super(TopRatedMoviesEmpty());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    final result = await _getTopRatedMovies.execute();

    result.fold(
          (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
          (tvData) {
        emit(TopRatedMoviesHasData(tvData));
      },
    );
  }


}
