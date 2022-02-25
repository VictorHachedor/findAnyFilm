// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIFilmQuery _$APIFilmQueryFromJson(Map<String, dynamic> json) => APIFilmQuery(
      results: (json['results'] as List<dynamic>)
          .map((e) => APIResults.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int?,
    );

Map<String, dynamic> _$APIFilmQueryToJson(APIFilmQuery instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
    };

APIResults _$APIResultsFromJson(Map<String, dynamic> json) => APIResults(
      title: json['title'] as String?,
      posterPath: json['poster_path'] as String?,
      id: json['id'] as int?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      genreIds: json['genre_ids'] as List<dynamic>?,
    );

Map<String, dynamic> _$APIResultsToJson(APIResults instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'popularity': instance.popularity,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'genre_ids': instance.genreIds,
      'poster_path': instance.posterPath,
    };

APICreditsQuery _$APICreditsQueryFromJson(Map<String, dynamic> json) =>
    APICreditsQuery(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => APICast.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..crew = (json['crew'] as List<dynamic>?)
        ?.map((e) => APICrew.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$APICreditsQueryToJson(APICreditsQuery instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
    };

APICast _$APICastFromJson(Map<String, dynamic> json) => APICast(
      actorsName: json['name'] as String?,
      character: json['character'] as String?,
    );

Map<String, dynamic> _$APICastToJson(APICast instance) => <String, dynamic>{
      'name': instance.actorsName,
      'character': instance.character,
    };

APICrew _$APICrewFromJson(Map<String, dynamic> json) => APICrew(
      crewMemberName: json['name'] as String?,
      job: json['job'] as String?,
    );

Map<String, dynamic> _$APICrewToJson(APICrew instance) => <String, dynamic>{
      'name': instance.crewMemberName,
      'job': instance.job,
    };

APIFilmDetailsQuery _$APIFilmDetailsQueryFromJson(Map<String, dynamic> json) =>
    APIFilmDetailsQuery(
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => APIGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      runtime: json['runtime'] as int?,
    )
      ..id = json['id'] as int?
      ..popularity = (json['popularity'] as num?)?.toDouble()
      ..image = json['poster_path'] as String?
      ..title = json['title'] as String?
      ..overview = json['overview'] as String?
      ..releaseDate = json['release_date'] as String?;

Map<String, dynamic> _$APIFilmDetailsQueryToJson(
        APIFilmDetailsQuery instance) =>
    <String, dynamic>{
      'id': instance.id,
      'runtime': instance.runtime,
      'popularity': instance.popularity,
      'genres': instance.genres,
      'poster_path': instance.image,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
    };

APIGenre _$APIGenreFromJson(Map<String, dynamic> json) => APIGenre(
      genreName: json['name'] as String?,
    );

Map<String, dynamic> _$APIGenreToJson(APIGenre instance) => <String, dynamic>{
      'name': instance.genreName,
    };
