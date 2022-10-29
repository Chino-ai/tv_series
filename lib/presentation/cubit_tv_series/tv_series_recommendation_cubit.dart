import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_series_recommendation.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/movies/get_now_playing_movies.dart';
import '../../domain/usecases/movies/get_top_rated_movies.dart';
part 'tv_series_recommendation_state.dart';



class TvRecommendationCubit extends Cubit<TvRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvRecommendationCubit(this.getTvSeriesRecommendations)
      : super(TvRecommendationEmpty());

  Future<void> fetchTvRecommendation(int id) async {
    emit(TvRecommendationLoading());
    final result = await getTvSeriesRecommendations.execute(id);

    result.fold(
          (failure) {
        emit(TvRecommendationError(failure.message));
      },
          (tvData) {
        emit(TvRecommendationHasData(tvData));
      },
    );
  }




}
