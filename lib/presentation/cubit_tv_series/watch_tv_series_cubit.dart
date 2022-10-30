import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import '../../common/constants.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/entities/tv/tv_series_detail.dart';
import '../../domain/usecases/tv/get_watchlist_status.dart';
import '../../domain/usecases/tv/save_watchlist.dart';
import '../../domain/usecases/tv/tv_series_remove_watchlist.dart';

part 'watch_tv_series_state.dart';



class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  final GetWatchListTvSeriesStatus getWatchListStatus;
  final TvSeriesSaveWatchlist saveWatchlist;
  final TvSeriesRemoveWatchlist removeWatchlist;



  String message = '';

  WatchlistTvSeriesCubit(this.getWatchlistTvSeries,this.getWatchListStatus,this.saveWatchlist,this.removeWatchlist)
      : super(WatchlistTvSeriesEmpty());

  Future<void> fetchWatchlistTv() async {
    emit(WatchlistTvSeriesLoading());
    final result = await getWatchlistTvSeries.execute();

    result.fold(
          (failure) {
        emit(WatchlistTvSeriesError(failure.message));
      },
          (tvData) {
        emit(WatchlistTvSeriesHasData(tvData));
      },
    );
  }

  Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);

    await result.fold(
          (failure) async {
        emit(TvAddWatchlistState(false));
        message = failure.message;
      },
          (successMessage) async {
        emit(TvAddWatchlistState(true));
        message = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    await result.fold(
          (failure) async {
        emit(TvAddWatchlistState(true));
        message = failure.message;
      },
          (successMessage) async {
        emit(TvAddWatchlistState(false));
        message = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    result
        ? message = watchlistAddSuccessMessage
        : message = watchlistRemoveSuccessMessage;
    emit(TvAddWatchlistState(result));
  }


}
