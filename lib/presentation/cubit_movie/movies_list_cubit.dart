import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/movies/get_now_playing_movies.dart';
import '../../domain/usecases/movies/get_top_rated_movies.dart';
part 'movies_list_state.dart';



class MoviesListCubit extends Cubit<MoviesListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MoviesListCubit(this._getNowPlayingMovies)
      : super(MoviesListEmpty());

  Future<void> fetchNowPlayingMovies() async {
    emit(MoviesListLoading());
    final result = await _getNowPlayingMovies.execute();

    result.fold(
          (failure) {
        emit(MoviesListError(failure.message));
      },
          (tvData) {
        emit(MoviesListHasData(tvData));
      },
    );
  }




}
