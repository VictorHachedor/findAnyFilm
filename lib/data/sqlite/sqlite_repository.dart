import 'package:find_any_movie/data/models/data_models.dart';
import 'package:find_any_movie/data/sqlite/database_helper.dart';

import '../repository.dart';

class SqliteRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<SavedFilmModel>> findAllSavedFilms() {
    return dbHelper.findAllFilms();
  }

  @override
  Stream<List<SavedFilmModel>> watchAllSavedFilms() {
    return dbHelper.watchAllSavedFilms();
  }

  @override
  Future<SavedFilmModel> findSavedFilmById(int id) {
    return dbHelper.findSavedFilmById(id);
  }

  @override
  Future<int> insertSavedFilm(SavedFilmModel savedFilm) {
    return Future(() async {
      final id = await dbHelper.insertFilm(savedFilm);
      savedFilm.id = id;
      return id;
    });
  }

  @override
  Future<void> deleteSavedFilm(SavedFilmModel savedFilm) {
    dbHelper.deleteFilm(savedFilm);
    return Future.value();
  }

  @override
  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  @override
  void close() {
    dbHelper.close();
  }
}
