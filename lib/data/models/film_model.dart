import 'package:equatable/equatable.dart';

import 'cast_model.dart';
import 'genre_model.dart';

class FilmModel extends Equatable {
  final int? id;
  final double? popularity;
  final int? runtime;
  final int? genreIds;
  final List<GenreModel>? genres;
  final String? image;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final List<CastModel>? cast;

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
        cast
      ];
}
