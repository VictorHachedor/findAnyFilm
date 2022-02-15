import 'dart:core';

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
  String? title;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  APIResults({
    required this.title,
    required this.posterPath,
  });

  factory APIResults.fromJson(Map<String, dynamic> json) =>
      _$APIResultsFromJson(json);

  Map<String, dynamic> toJson() => _$APIResultsToJson(this);
}
