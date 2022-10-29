part of 'watch_tv_series_cubit.dart';




class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();
  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  const WatchlistTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvAddWatchlistState extends WatchlistTvSeriesState {
  bool isAddedToWatchlist = false;

  TvAddWatchlistState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
