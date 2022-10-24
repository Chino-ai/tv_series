import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data_tv/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetailSeries(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}
