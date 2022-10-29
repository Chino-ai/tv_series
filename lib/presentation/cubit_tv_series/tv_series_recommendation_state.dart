part of 'tv_series_recommendation_cubit.dart';




class TvRecommendationState extends Equatable {
  const TvRecommendationState();
  @override
  List<Object> get props => [];
}

class TvRecommendationEmpty extends TvRecommendationState {}

class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  const TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
class TvRecommendationHasData extends TvRecommendationState {
  final List<TvSeries> result;

  const TvRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}



