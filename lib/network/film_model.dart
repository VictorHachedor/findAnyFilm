import 'dart:core';

import 'package:find_any_movie/data/models/data_models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'film_model.g.dart';

@JsonSerializable()
class APIFilmQuery {
  factory APIFilmQuery.fromJson(Map<String, dynamic> json) =>
      _$APIFilmQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIFilmQueryToJson(this);

  List<APIResults> results;
  int? page;

  APIFilmQuery({
    required this.results,
    required this.page,
  });
}

@JsonSerializable()
class APIResults {
  int? id;
  String? title;
  double? popularity;
  String? overview;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'genre_ids')
  List<dynamic>? genreIds;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  APIResults({
    required this.title,
    required this.posterPath,
    required this.id,
    required this.popularity,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
  });

  factory APIResults.fromJson(Map<String, dynamic> json) =>
      _$APIResultsFromJson(json);

  Map<String, dynamic> toJson() => _$APIResultsToJson(this);
}

@JsonSerializable()
class APICreditsQuery {
  List<APICast>? cast;
  List<APICrew>? crew;

  APICreditsQuery({required this.cast});

  factory APICreditsQuery.fromJson(Map<String, dynamic> json) =>
      _$APICreditsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APICreditsQueryToJson(this);
}

@JsonSerializable()
class APICast {
  @JsonKey(name: 'name')
  String? actorsName;

  String? character;

  APICast({required this.actorsName, required this.character});

  factory APICast.fromJson(Map<String, dynamic> json) =>
      _$APICastFromJson(json);

  Map<String, dynamic> toJson() => _$APICastToJson(this);
}

@JsonSerializable()
class APICrew {
  @JsonKey(name: 'name')
  String? crewMemberName;

  String? job;

  APICrew({required this.crewMemberName, required this.job});

  factory APICrew.fromJson(Map<String, dynamic> json) =>
      _$APICrewFromJson(json);

  Map<String, dynamic> toJson() => _$APICrewToJson(this);
}

@JsonSerializable()
class APIFilmDetailsQuery {
  int? id;
  int? runtime;
  double? popularity;
  List<APIGenre>? genres;

  @JsonKey(name: 'poster_path')
  String? image;

  String? title;
  String? overview;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  APIFilmDetailsQuery({required this.genres, required this.runtime});

  factory APIFilmDetailsQuery.fromJson(Map<String, dynamic> json) =>
      _$APIFilmDetailsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIFilmDetailsQueryToJson(this);
}

@JsonSerializable()
class APIGenre {
  @JsonKey(name: 'name')
  String? genreName;

  APIGenre({required this.genreName});

  factory APIGenre.fromJson(Map<String, dynamic> json) =>
      _$APIGenreFromJson(json);

  Map<String, dynamic> toJson() => _$APIGenreToJson(this);
}
