part of 'tv_series_list_cubit.dart';




class TvSeriesListState extends Equatable {
  const TvSeriesListState();
  @override
  List<Object> get props => [];
}

class TvSeriesListEmpty extends TvSeriesListState {}

class TvSeriesListLoading extends TvSeriesListState {}

class TvSeriesListError extends TvSeriesListState {
  final String message;

  const TvSeriesListError(this.message);

  @override
  List<Object> get props => [message];
}
class TvOnAirHasData extends TvSeriesListState {
  final List<TvSeries> result;

  const TvOnAirHasData(this.result);

  @override
  List<Object> get props => [result];
}



