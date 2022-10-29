import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/tv/search_tv_series.dart';

part 'movies_search_state.dart';



class MoviesSearchCubit extends Cubit<MoviesSearchState> {
  final SearchMovies getMoviesSearch;

  MoviesSearchCubit(this.getMoviesSearch)
      : super(MoviesSearchEmpty());

  Future<void> fetchMovieSearch(id) async {
    emit(MoviesSearchLoading());
    final result = await getMoviesSearch.execute(id);

    result.fold(
          (failure) {
        emit(MoviesSearchError(failure.message));
      },
          (tvData) {
        emit(MoviesSearchHasData(tvData));
      },
    );
  }


}
