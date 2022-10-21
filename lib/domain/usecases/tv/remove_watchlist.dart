import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/tv/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class TvRemoveWatchlist {
  final TvRepository repository;

  TvRemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
