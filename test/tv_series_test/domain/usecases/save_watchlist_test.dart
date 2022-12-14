import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_tv/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesSaveWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = TvSeriesSaveWatchlist(mockTvRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
