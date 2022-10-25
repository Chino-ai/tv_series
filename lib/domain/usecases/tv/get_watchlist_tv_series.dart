import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../../entities/tv/tv_series.dart';
import '../../repositories/tv_repository.dart';

class GetWatchlistTvSeries {
  final TvRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTv();
  }
}
