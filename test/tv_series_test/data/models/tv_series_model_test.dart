import 'package:ditonton/data/models/tv/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvSeriesModel(
    backdropPath: '/path.jpg',
    genreIds: [1,2],
    id: 1,
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1,
    posterPath: '/path.jpg',
    firstAirDate: '2020-05-05',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = TvSeries(
    backdropPath: '/path.jpg',
    genreIds: [1,2],
    id: 1,
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1,
    posterPath: '/path.jpg',
    firstAirDate: '2020-05-05',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
