import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/movies/get_watchlist_movies.dart';
import '../../domain/usecases/movies/get_watchlist_status.dart';
import '../../domain/usecases/movies/remove_watchlist.dart';
import '../../domain/usecases/movies/save_watchlist.dart';
part 'watchlist_movies_state.dart';



class WatchlistMoviesCubit extends Cubit<WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;


  String message = '';

  WatchlistMoviesCubit(this._getWatchlistMovies,this.getWatchListStatus,this.saveWatchlist,this.removeWatchlist)
      : super(WatchlistMoviesEmpty());

  Future<void> fetchWatchlistMovies() async {
    emit(WatchlistMoviesLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold(
          (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
          (tvData) {
        emit(WatchlistMoviesHasData(tvData));
      },
    );
  }

  Future<void> addWatchlist(MovieDetail detail) async {
    emit(WatchlistMoviesLoading());
    final result = await saveWatchlist.execute(detail);
    result.fold(
          (failure) async {
        emit(MovieAddWatchlistState(false));
        message = failure.message;
      },
          (succesMessage) async {
        emit(MovieAddWatchlistState(true));
        message = succesMessage;
      },

    );
    await loadWatchlistStatus(detail.id);
  }

  Future<void> removesWatchlist(MovieDetail detail) async {
    emit(WatchlistMoviesLoading());
    final result = await removeWatchlist.execute(detail);
    result.fold(
          (failure) async {
        emit(MovieAddWatchlistState(true));
        message = failure.message;
      },
          (succesMessage) async {
        emit(MovieAddWatchlistState(false));
        message = succesMessage;
      },

    );
    await loadWatchlistStatus(detail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    emit(WatchlistMoviesLoading());
    final result = await getWatchListStatus.execute(id);
    result
        ? message = watchlistAddSuccessMessage
        : message = watchlistRemoveSuccessMessage;
    emit(MovieAddWatchlistState(result));
  }


}
