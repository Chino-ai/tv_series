import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/presentation/provider/tv/watch_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_tv/dummy_objects.dart';
import 'watchlist_tv_series_notifier_test.mocks.dart';

@GenerateMocks([TvSeriesSaveWatchlist])
void main() {
  late WatchlistTvSeriesNotifier provider;
  late MockGetWatchListTvSeries mockGetWatchListTvSeries ;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTvSeries = MockGetWatchListTvSeries();
    provider = WatchlistTvSeriesNotifier(
      getWatchlistTv: mockGetWatchListTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchListTvSeries.execute())
        .thenAnswer((_) async => Right([testWatchListTv]));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTv, [testWatchListTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchListTvSeries.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
