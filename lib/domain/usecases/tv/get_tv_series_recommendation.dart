import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/tv/tv_series.dart';
import '../../repositories/tv_repository.dart';

class GetTvSeriesRecommendations {
  final TvRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
