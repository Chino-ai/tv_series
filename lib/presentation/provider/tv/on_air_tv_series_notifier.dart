import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/tv/tv_series.dart';
import '../../../domain/usecases/tv/get_on_air_tv_series.dart';

class OnAirTvSeriesNotifier extends ChangeNotifier {
  final GetOnAirTvSeries getOnAirTv;

  OnAirTvSeriesNotifier({required this.getOnAirTv});
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<TvSeries> _tv = [];
  List<TvSeries> get tv => _tv;
  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
