import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/tv/get_on_air_tv_series.dart';
import '../../domain/usecases/tv/get_popular_tv_series.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesCubit(this.getPopularTvSeries)
      : super(PopularTvSeriesEmpty());

  Future<void> fetchPopularTv() async {
    emit(PopularTvSeriesLoading());
    final result = await getPopularTvSeries.execute();

    result.fold(
          (failure) {
        emit(PopularTvSeriesError(failure.message));
      },
          (tvData) {
        emit(PopularTvSeriesHasData(tvData));
      },
    );
  }


}
