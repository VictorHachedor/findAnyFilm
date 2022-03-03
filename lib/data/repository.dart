import 'package:find_any_movie/data/models/data_models.dart';

abstract class Repository {
  Future<List<SavedFilmModel>> findAllSavedFilms();

  Stream<List<SavedFilmModel>> watchAllSavedFilms();

  Future<SavedFilmModel> findSavedFilmById(int id);

  Future<int> insertSavedFilm(SavedFilmModel savedFilm);

  Future<void> deleteSavedFilm(SavedFilmModel savedFilm);

  Future init();

  void close();
}
