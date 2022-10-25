import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../entities/tv/tv_series.dart';
import '../entities/tv/tv_series_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
  Future<Either<Failure, List<TvSeries>>> getOnAirTv();
  Future<Either<Failure, TvSeriesDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(id);
  Future<Either<Failure, List<TvSeries>>> getPopularTv();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv();
  Future<Either<Failure, List<TvSeries>>> searchTv(String query);

}
