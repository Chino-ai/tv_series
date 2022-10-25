import 'package:ditonton/data/models/tv/tv_series_genre_model.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/tv/tv_series_detail.dart';


class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.status,
    required this.tagline,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
    required this.genre,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
  });


  final String status;
  final String tagline;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double voteAverage;
  final int voteCount;
  final String? backdropPath;
  final List<TvSeriesGenreModel> genre;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        backdropPath: json["backdrop_path"],
        genre: List<TvSeriesGenreModel>.from(
            json["genres"].map((x) => TvSeriesGenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        status: json["status"],
        tagline: json["tagline"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],


      );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genres": List<dynamic>.from(genre.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date": firstAirDate,
    "status": status,
    "tagline": tagline,
    "name": name,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons":numberOfSeasons,
    "vote_average": voteAverage,
    "vote_count": voteCount,


      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: this.backdropPath,
      genre: this.genre.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    popularity,
    posterPath,
    firstAirDate,
    status,
    tagline,
    name,
    voteAverage,
    voteCount,
    backdropPath,
    genre,
    homepage,
    id,
    originalLanguage,
    originalName,
    overview,
      ];
}
