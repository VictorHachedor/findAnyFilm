import 'dart:core';
import 'package:flutter/foundation.dart';
import 'repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  final List<SavedFilmModel> _currentFilms = <SavedFilmModel>[];

  @override
  List<SavedFilmModel> findAllFilms() {
    return _currentFilms;
  }

  @override
  SavedFilmModel findFilmById(int id) {
    return _currentFilms.firstWhere((savedFilm) => savedFilm.id == id);
  }

  @override
  int insertFilm(SavedFilmModel savedFilm) {
    _currentFilms.add(savedFilm);
    notifyListeners();
    return 0;
  }

  @override
  void deleteSavedFilm(SavedFilmModel savedFilm) {
    _currentFilms.remove(savedFilm);
    notifyListeners();
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}
