import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_series_table.dart';
import 'database_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvSeriesTable tv);
  Future<String> removeWatchlist(TvSeriesTable tv);
  Future<TvSeriesTable?> getTvById(int id);
  Future<List<TvSeriesTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper tvdatabaseHelper;

  TvLocalDataSourceImpl({required this.tvdatabaseHelper});

  @override
  Future<String> insertWatchlist(TvSeriesTable tv) async {
    try {
      await tvdatabaseHelper.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tv) async {
    try {
      await tvdatabaseHelper.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvById(int id) async {
    final result = await tvdatabaseHelper.getTvById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTv() async {
    final result = await tvdatabaseHelper.getWatchlistTv();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }


}
