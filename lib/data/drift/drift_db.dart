import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:find_any_movie/data/models/data_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_db.g.dart';

class DriftFilm extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get popularity => real()();
  IntColumn get runtime => integer()();
  TextColumn get image => text()();
  TextColumn get title => text()();
  TextColumn get overview => text()();
  TextColumn get releaseDate => text()();
}

@DriftDatabase(tables: [DriftFilm], daos: [FilmDao])
class FilmDatabase extends _$FilmDatabase {
  FilmDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'films.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftAccessor(tables: [DriftFilm])
class FilmDao extends DatabaseAccessor<FilmDatabase> with _$FilmDaoMixin {
  final FilmDatabase db;
  FilmDao(this.db) : super(db);
  Future<List<DriftFilmData>> findAllSavedFilms() => select(driftFilm).get();
  Stream<List<SavedFilmModel>> watchAllSavedFilms() {
    return select(driftFilm).watch().map((rows) {
      final savedFilms = <SavedFilmModel>[];
      for (var row in rows) {
        final savedFilm = driftSavedFilmToSavedFilm(row);
        if (!savedFilms.contains(savedFilm)) {
          savedFilms.add(savedFilm);
        }
      }
      return savedFilms;
    });
  }

  Future<List<DriftFilmData>> findSavedFilmById(int id) =>
      (select(driftFilm)..where((tbl) => tbl.id.equals(id))).get();
  Future<int> insertFilm(Insertable<DriftFilmData> film) =>
      into(driftFilm).insert(film);
  Future deleteFilm(int id) =>
      Future.value((delete(driftFilm)..where((tbl) => tbl.id.equals(id))).go());
}

SavedFilmModel driftSavedFilmToSavedFilm(DriftFilmData savedFilm) {
  return SavedFilmModel(
    id: savedFilm.id,
    popularity: savedFilm.popularity,
    runtime: savedFilm.runtime,
    image: savedFilm.image,
    title: savedFilm.title,
  );
}

Insertable<DriftFilmData> savedFilmToInsertableDriftSavedFilm(
    SavedFilmModel savedFilm) {
  return DriftFilmCompanion.insert(
    popularity: savedFilm.popularity ?? 0.0,
    runtime: savedFilm.runtime ?? 0,
    image: savedFilm.image ?? '',
    title: savedFilm.title ?? '', 
    releaseDate: '', 
    overview: '',
    
  );
}
