import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:equatable/equatable.dart';


import '../../domain/entities/movie_detail.dart';

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
