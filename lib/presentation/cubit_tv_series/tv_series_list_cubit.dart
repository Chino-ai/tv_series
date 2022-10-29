import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_on_air_tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv/tv_series.dart';
import '../../domain/usecases/tv/get_popular_tv_series.dart';
import '../../domain/usecases/tv/get_top_rated_tv_series.dart';
import '../../domain/usecases/tv/get_tv_detail_series.dart';

part 'tv_series_list_state.dart';



class TvSeriesListCubit extends Cubit<TvSeriesListState> {
  final GetOnAirTvSeries getOnAirTvSeries;

  TvSeriesListCubit(this.getOnAirTvSeries)
      : super(TvSeriesListEmpty());

  Future<void> fetchNowPlayingTv() async {
    emit(TvSeriesListLoading());
    final result = await getOnAirTvSeries.execute();

    result.fold(
          (failure) {
        emit(TvSeriesListError(failure.message));
      },
          (tvData) {
        emit(TvOnAirHasData(tvData));
      },
    );
  }







}
