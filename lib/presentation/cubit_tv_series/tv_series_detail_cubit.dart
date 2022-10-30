import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/tv/get_tv_detail_series.dart';
part 'tv_series_detail_state.dart';



class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  final GetTvDetailSeries getTvSeriesDetail;

  TvSeriesDetailCubit(
      this.getTvSeriesDetail,
      )
      : super(TvSeriesDetailEmpty());

  Future<void> fetchTvDetail(int id) async {
    emit(TvSeriesDetailLoading());
    final result = await getTvSeriesDetail.execute(id);

    result.fold(
          (failure) {
        emit(TvSeriesDetailError(failure.message));
      },
          (tvData) async {
        emit(TvSeriesDetailHasData(tvData));
      },
    );
  }



}
