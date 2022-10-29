import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/movies/get_movie_recommendations.dart';
import '../../domain/usecases/movies/get_watchlist_status.dart';
import '../../domain/usecases/movies/remove_watchlist.dart';
import '../../domain/usecases/movies/save_watchlist.dart';
import '../../domain/usecases/tv/get_tv_detail_series.dart';

part 'movies_detail_state.dart';



class MoviesDetailCubit extends Cubit<MoviesDetailState> {
  final GetMovieDetail getMoviesDetail;


  MoviesDetailCubit(this.getMoviesDetail)
      : super(MoviesDetailEmpty());

  Future<void> fetchMoviesDetail(int id) async {
    emit(MoviesDetailLoading());
    final result = await getMoviesDetail.execute(id);

    result.fold(
          (failure) {
        emit(MoviesDetailError(failure.message));
      },
          (tvData) {
        emit(MoviesDetailHasData(tvData));
      },

    );
  }




}
