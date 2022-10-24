import 'package:ditonton/data/models/tv/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_series_genre.dart';

final testTv = TvSeries(
  backdropPath: '/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg',
  genreIds: [10765,
    18,
    10759],
  id: 94997,
  originalName: 'House of the Dragon',
  overview: "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  popularity: 4495.747,
  posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
  firstAirDate: '2022-08-21',
  name: 'House of the Dragon',
  voteAverage: 8.5,
  voteCount: 1889,
);

final testTvList = [testTv];

final testTvDetail =TvSeriesDetail(
  backdropPath: 'backdropPath',
  genre: [TvSeriesGenre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  voteAverage: 1,
  voteCount: 1,
);

final testWatchListTv = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'posterPath': 'posterPath',
  'overview': 'overview',
  'name': 'name',
};
