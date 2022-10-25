import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_series.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/tv/tv_series.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTv;

  TvSeriesSearchNotifier({required this.searchTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
