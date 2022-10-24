import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_on_air_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetOnAirTvSeries(mockTvRepository);
  });

  final tTv = <TvSeries>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvRepository.getOnAirTv())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
