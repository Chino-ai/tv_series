import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/tv/tv_series.dart';
import '../../repositories/tv_repository.dart';

class GetTopRatedTvSeries {
  final TvRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTv();
  }
}