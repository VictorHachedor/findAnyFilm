import 'package:equatable/equatable.dart';

class SavedFilmModel extends Equatable {
   int? id;
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

  factory SavedFilmModel.fromJson(Map<String, dynamic> json) => SavedFilmModel(
        id: json['id'],
        popularity: json['popularity'],
        runtime: json['runtime'],
        image: json['image'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'popularity': popularity,
        'runtime': runtime,
        'image': image,
        'title': title,
      };
}
