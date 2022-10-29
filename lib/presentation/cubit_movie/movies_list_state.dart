part of 'movies_list_cubit.dart';




class MoviesListState extends Equatable {
  const MoviesListState();
  @override
  List<Object> get props => [];
}

class MoviesListEmpty extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListError extends MoviesListState {
  final String message;

  const MoviesListError(this.message);

  @override
  List<Object> get props => [message];
}
class MoviesListHasData extends MoviesListState {
  final List<Movie> result;

  const MoviesListHasData(this.result);

  @override
  List<Object> get props => [result];
}



