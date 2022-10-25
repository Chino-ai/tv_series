import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../../entities/tv/tv_series_detail.dart';
import '../../repositories/tv_repository.dart';

class TvSeriesSaveWatchlist {
  final TvRepository repository;

  TvSeriesSaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
