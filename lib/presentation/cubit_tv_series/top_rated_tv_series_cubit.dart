import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/tv/get_top_rated_tv_series.dart';
part 'top_rated_tv_series_state.dart';



class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesCubit(this.getTopRatedTvSeries)
      : super(TopRatedTvSeriesEmpty());

  Future<void> fetchTopRatedTv() async {
    emit(TopRatedTvSeriesLoading());
    final result = await getTopRatedTvSeries.execute();

    result.fold(
          (failure) {
        emit(TopRatedTvSeriesError(failure.message));
      },
          (tvData) {
        emit(TopRatedTvSeriesHasData(tvData));
      },
    );
  }


}
