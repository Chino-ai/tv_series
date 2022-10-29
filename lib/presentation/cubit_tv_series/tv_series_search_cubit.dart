import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/tv/search_tv_series.dart';

part 'tv_series_search_state.dart';



class TvSeriesSearchCubit extends Cubit<TvSeriesSearchState> {
  final SearchTvSeries getTvSeriesSearch;

  TvSeriesSearchCubit(this.getTvSeriesSearch)
      : super(TvSeriesSearchEmpty());

  Future<void> fetchTvSearch(id) async {
    emit(TvSeriesSearchLoading());
    final result = await getTvSeriesSearch.execute(id);

    result.fold(
          (failure) {
        emit(TvSeriesSearchError(failure.message));
      },
          (tvData) {
        emit(TvSeriesSearchHasData(tvData));
      },
    );
  }


}
