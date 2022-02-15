import 'package:equatable/equatable.dart';

import 'cast_model.dart';
import 'genre_model.dart';

class FilmModel extends Equatable {
  final int? id;
  final int? popularity;
  final int? runtime;
  final int? genreIds;
  final List<GenreModel>? genres;
  final String? image;
  final String? label;
  final String? overview;
  final String? releaseDate;
  final List<CastModel>? cast;

  const FilmModel(
      this.id,
      this.popularity,
      this.runtime,
      this.genreIds,
      this.genres,
      this.image,
      this.label,
      this.overview,
      this.releaseDate,
      this.cast);

  @override
  List<Object?> get props => [
        id,
        popularity,
        runtime,
        genreIds,
        genres,
        image,
        label,
        overview,
        releaseDate,
        cast
      ];
}
