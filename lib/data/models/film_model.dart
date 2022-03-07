import 'package:equatable/equatable.dart';
import 'package:find_any_movie/network/film_model.dart';

import 'cast_model.dart';
import 'genre_model.dart';

class FilmModel extends Equatable {
  final int? id;
  final double? popularity;
  final int? runtime;
  final int? genreIds;
  final List<APIGenre>? genres;
  final String? image;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? youtubeKey;
  final List<APICrew>? crew;
  final List<APICast>? cast;

  const FilmModel(
      {this.id,
      this.popularity,
      this.runtime,
      this.genreIds,
      this.genres,
      this.image,
      this.title,
      this.overview,
      this.releaseDate,
      this.youtubeKey,
      this.crew,
      this.cast});

  @override
  List<Object?> get props => [
        id,
        popularity,
        runtime,
        genreIds,
        genres,
        image,
        title,
        overview,
        releaseDate,
        youtubeKey,
        crew,
        cast,
      ];

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
        id: json['id'],
        popularity: json['popularity'],
        runtime: json['runtime'],
        image: json['image'],
        title: json['title'],
        overview: json['overview'],
        releaseDate: json['releaseDate'],
        youtubeKey: json['youtube_key'],
        crew: json['crew'],
        cast: json['cast'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'popularity': popularity,
        'runtime': runtime,
        'image': image,
        'title': title,
        'overview': overview,
        'releaseDate': releaseDate,
        'youtube_key': youtubeKey,
        'crew': crew,
        'cast': cast,
      };
}
