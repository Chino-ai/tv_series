import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../../entities/tv/tv_series_detail.dart';
import '../../repositories/tv_repository.dart';

class GetTvDetailSeries {
  final TvRepository repository;

  GetTvDetailSeries(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id){
    return repository.getTvDetail(id);
  }
}