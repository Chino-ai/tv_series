import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/tv/tv_series_detail.dart';
import '../../repositories/tv_repository.dart';

class TvSeriesRemoveWatchlist {
  final TvRepository repository;

  TvSeriesRemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
