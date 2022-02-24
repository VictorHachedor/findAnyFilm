import 'package:find_any_movie/data/models/data_models.dart';

abstract class Repository {
  List<SavedFilmModel> findAllFilms();

  SavedFilmModel findFilmById(int id);

  int insertFilm(SavedFilmModel savedFilm);

  void deleteSavedFilm(SavedFilmModel savedFilm);

  Future init();

  void close();
}
