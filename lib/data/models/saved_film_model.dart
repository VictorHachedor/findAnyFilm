import 'package:equatable/equatable.dart';

class SavedFilmModel extends Equatable {
  final int? id;
  final String? image;
  final String? title;
  int? runtime;
  final double? popularity;

   SavedFilmModel(
      { this.id,
       this.image,
       this.title,
       this.runtime,
       this.popularity});

  @override
  List<Object?> get props => [id, image, title, runtime, popularity];
}
