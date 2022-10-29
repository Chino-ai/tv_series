import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/movies/get_now_playing_movies.dart';
import '../../domain/usecases/movies/get_top_rated_movies.dart';
part 'movies_recommendation_state.dart';



class MoviesRecommendationCubit extends Cubit<MoviesRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MoviesRecommendationCubit(this.getMovieRecommendations)
      : super(MoviesRecommendationEmpty());

  Future<void> fetchMovieRecommendation(int id) async {
    emit(MoviesRecommendationLoading());
    final result = await getMovieRecommendations.execute(id);

    result.fold(
          (failure) {
        emit(MoviesRecommendationError(failure.message));
      },
          (tvData) {
        emit(MoviesRecommendationHasData(tvData));
      },
    );
  }




}
