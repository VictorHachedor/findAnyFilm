// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIFilmQuery _$APIFilmQueryFromJson(Map<String, dynamic> json) {
  return APIFilmQuery(
    results: (json['results'] as List<dynamic>)
        .map((e) => APIResults.fromJson(e as Map<String, dynamic>))
        .toList(),
    page: json['page'] as int?,
  );
}

Map<String, dynamic> _$APIFilmQueryToJson(APIFilmQuery instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
    };

APIResults _$APIResultsFromJson(Map<String, dynamic> json) {
  return APIResults(
    title: json['title'] as String?,
    posterPath: json['poster_path'] as String?,
  );
}

Map<String, dynamic> _$APIResultsToJson(APIResults instance) =>
    <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.posterPath,
    };
