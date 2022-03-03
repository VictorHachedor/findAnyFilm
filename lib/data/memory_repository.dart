import 'dart:async';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  final List<SavedFilmModel> _currentFilms = <SavedFilmModel>[];
  final StreamController _savedFilmStreamController =
      StreamController<List<SavedFilmModel>>();

  Stream<List<SavedFilmModel>>? _savedFilmsStream;
  @override
  Future<List<SavedFilmModel>> findAllSavedFilms() {
    return Future.value(_currentFilms);
  }

  @override
  Future<SavedFilmModel> findSavedFilmById(int id) {
    return Future.value(
      _currentFilms.firstWhere((savedFilm) => savedFilm.id == id),
    );
  }

  @override
  Stream<List<SavedFilmModel>> watchAllSavedFilms() {
    _savedFilmsStream ??=
        _savedFilmStreamController.stream as Stream<List<SavedFilmModel>>;
    return _savedFilmsStream!;
  }

  @override
  Future<int> insertSavedFilm(SavedFilmModel savedFilm) {
    _currentFilms.add(savedFilm);
    notifyListeners();
    return Future.value(0);
  }

  @override
  Future<void> deleteSavedFilm(SavedFilmModel savedFilm) {
    _currentFilms.remove(savedFilm);
    return Future.value();
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}
