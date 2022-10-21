import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_on_air_tv.dart';

class OnAirTvNotifier extends ChangeNotifier {
  final GetOnAirTv getOnAirTv;

  OnAirTvNotifier({required this.getOnAirTv});
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<Tv> _tv = [];
  List<Tv> get tv => _tv;
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
