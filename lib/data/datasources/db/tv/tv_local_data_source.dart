import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';
import 'database_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper tvdatabaseHelper;

  TvLocalDataSourceImpl({required this.tvdatabaseHelper});

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await tvdatabaseHelper.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await tvdatabaseHelper.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await tvdatabaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await tvdatabaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }


}
