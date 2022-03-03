import 'package:find_any_movie/data/models/data_models.dart';

import '../repository.dart';
import 'drift_db.dart';

class DriftRepository extends Repository {
  late FilmDatabase filmDatabase;
  late FilmDao _filmDao;
  Stream<List<SavedFilmModel>>? savedFilmStream;

  @override
  Future<List<SavedFilmModel>> findAllSavedFilms() {
    return _filmDao.findAllSavedFilms().then<List<SavedFilmModel>>(
      (List<DriftFilmData> driftFilms) {
        final savedFilms = <SavedFilmModel>[];
        driftFilms.forEach(
          (driftFilm) async {
            final savedFilm = driftSavedFilmToSavedFilm(driftFilm);
            savedFilms.add(savedFilm);
          },
        );
        return savedFilms;
      },
    );
  }

  @override
  Stream<List<SavedFilmModel>> watchAllSavedFilms() {
    savedFilmStream ??= _filmDao.watchAllSavedFilms();
    return savedFilmStream!;
  }

  @override
  Future<SavedFilmModel> findSavedFilmById(int id) {
    return _filmDao
        .findSavedFilmById(id)
        .then((listOfFilms) => driftSavedFilmToSavedFilm(listOfFilms.first));
  }

  @override
  Future<int> insertSavedFilm(SavedFilmModel savedFilm) {
    return Future(() async {
      final id = await _filmDao
          .insertFilm(savedFilmToInsertableDriftSavedFilm(savedFilm));
      return id;
    });
  }

  @override
  Future<void> deleteSavedFilm(SavedFilmModel savedFilm) {
    if (savedFilm.id != null) {
      _filmDao.deleteFilm(savedFilm.id!);
    }
    return Future.value();
  }

  @override
  Future init() async {
    filmDatabase = FilmDatabase();
    _filmDao = filmDatabase.filmDao;
  }

  @override
  void close() {
    filmDatabase.close();
  }
}
