part of 'movies_detail_cubit.dart';




class MoviesDetailState extends Equatable {
  const MoviesDetailState();
  @override
  List<Object> get props => [];
}

class MoviesDetailEmpty extends MoviesDetailState {}

class MoviesDetailLoading extends MoviesDetailState {}


class MoviesDetailError extends MoviesDetailState {
  final String message;

  const MoviesDetailError(this.message);

  @override
  List<Object> get props => [message];
}
class MoviesDetailHasData extends MoviesDetailState {
  final MovieDetail result;

  const MoviesDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}



