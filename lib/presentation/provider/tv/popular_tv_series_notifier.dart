import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/tv/tv_series.dart';


class PopularTvSeriesNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTv;

  PopularTvSeriesNotifier(this.getPopularTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tv = [];
  List<TvSeries> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();

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
