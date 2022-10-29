import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/tv/get_on_air_tv_series.dart';

part 'on_air_tv_series_state.dart';

class OnAirTvSeriesCubit extends Cubit<OnAirTvSeriesState> {
  final GetOnAirTvSeries getOnAirTvSeries;

  OnAirTvSeriesCubit(this.getOnAirTvSeries)
      : super(OnAirTvSeriesEmpty());

  Future<void> fetchOnAirTv() async {
    emit(OnAirTvSeriesLoading());
    final result = await getOnAirTvSeries.execute();
    result.fold(
          (failure) {
        emit(OnAirTvSeriesError(failure.message));
      },
          (tvData) {
        emit(OnAirTvSeriesHasData(tvData));
      },
    );
  }


}
