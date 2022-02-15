import 'package:equatable/equatable.dart';

class CastModel extends Equatable {
  final String? name;
  
  const CastModel(this.name);

  @override
  List<Object?> get props => [name];
}
