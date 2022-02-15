import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final String? genreName;

  const GenreModel(this.genreName);

  @override
  List<Object?> get props => [genreName];
}
