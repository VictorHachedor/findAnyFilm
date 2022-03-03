import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';
import '../models/data_models.dart';

class DatabaseHelper {
  static const _databaseName = 'MyFilms.db';
  static const _databaseVersion = 1;
  static const filmTable = 'Film';
  static const filmId = 'id';

  static late BriteDatabase _streamDatabase;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static var lock = Lock();

  static Database? _database;

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $filmTable (
  $filmId INTEGER PRIMARY KEY,
        popularity REAL,
        runtime INTEGER,
        image TEXT,
        title TEXT,
        overview TEXT,
        releaseDate TEXT
) ''');
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    // TODO remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<SavedFilmModel> parseFilms(List<Map<String, dynamic>> filmList) {
    final savedFilms = <SavedFilmModel>[];
    filmList.forEach((filmMap) {
      final savedFilm = SavedFilmModel.fromJson(filmMap);
      savedFilms.add(savedFilm);
    });
    return savedFilms;
  }

  Future<List<SavedFilmModel>> findAllFilms() async {
    final db = await instance.streamDatabase;
    final filmList = await db.query(filmTable);
    final films = parseFilms(filmList);
    return films;
  }

  Stream<List<SavedFilmModel>> watchAllSavedFilms() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(filmTable)
        .mapToList((row) => SavedFilmModel.fromJson(row));
  }

  Future<SavedFilmModel> findSavedFilmById(int id) async {
    final db = await instance.streamDatabase;
    final filmList = await db.query(filmTable, where: 'id = $id');
    final films = parseFilms(filmList);
    return films.first;
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertFilm(SavedFilmModel savedFilm) {
    return insert(filmTable, savedFilm.toJson());
  }

  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteFilm(SavedFilmModel savedFilm) async {
    if (savedFilm.id != null) {
      return _delete(filmTable, filmId, savedFilm.id!);
    } else {
      return Future.value(-1);
    }
  }

  void close() {
    _streamDatabase.close();
  }
}
