part of 'on_air_tv_series_cubit.dart';

class OnAirTvSeriesState extends Equatable {
  const OnAirTvSeriesState();
  @override
  List<Object> get props => [];


}

class OnAirTvSeriesEmpty extends OnAirTvSeriesState {}

class OnAirTvSeriesLoading extends OnAirTvSeriesState {}

class OnAirTvSeriesError extends OnAirTvSeriesState {
  final String message;

  const OnAirTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAirTvSeriesHasData extends OnAirTvSeriesState {
  final List<TvSeries> result;

  const OnAirTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
