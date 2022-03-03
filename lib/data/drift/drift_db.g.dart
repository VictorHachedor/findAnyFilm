// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DriftFilmData extends DataClass implements Insertable<DriftFilmData> {
  final int id;
  final double popularity;
  final int runtime;
  final String image;
  final String title;
  final String overview;
  final String releaseDate;
  DriftFilmData(
      {required this.id,
      required this.popularity,
      required this.runtime,
      required this.image,
      required this.title,
      required this.overview,
      required this.releaseDate});
  factory DriftFilmData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DriftFilmData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      popularity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity'])!,
      runtime: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}runtime'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      overview: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}overview'])!,
      releaseDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['popularity'] = Variable<double>(popularity);
    map['runtime'] = Variable<int>(runtime);
    map['image'] = Variable<String>(image);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    map['release_date'] = Variable<String>(releaseDate);
    return map;
  }

  DriftFilmCompanion toCompanion(bool nullToAbsent) {
    return DriftFilmCompanion(
      id: Value(id),
      popularity: Value(popularity),
      runtime: Value(runtime),
      image: Value(image),
      title: Value(title),
      overview: Value(overview),
      releaseDate: Value(releaseDate),
    );
  }

  factory DriftFilmData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftFilmData(
      id: serializer.fromJson<int>(json['id']),
      popularity: serializer.fromJson<double>(json['popularity']),
      runtime: serializer.fromJson<int>(json['runtime']),
      image: serializer.fromJson<String>(json['image']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'popularity': serializer.toJson<double>(popularity),
      'runtime': serializer.toJson<int>(runtime),
      'image': serializer.toJson<String>(image),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'releaseDate': serializer.toJson<String>(releaseDate),
    };
  }

  DriftFilmData copyWith(
          {int? id,
          double? popularity,
          int? runtime,
          String? image,
          String? title,
          String? overview,
          String? releaseDate}) =>
      DriftFilmData(
        id: id ?? this.id,
        popularity: popularity ?? this.popularity,
        runtime: runtime ?? this.runtime,
        image: image ?? this.image,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        releaseDate: releaseDate ?? this.releaseDate,
      );
  @override
  String toString() {
    return (StringBuffer('DriftFilmData(')
          ..write('id: $id, ')
          ..write('popularity: $popularity, ')
          ..write('runtime: $runtime, ')
          ..write('image: $image, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, popularity, runtime, image, title, overview, releaseDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftFilmData &&
          other.id == this.id &&
          other.popularity == this.popularity &&
          other.runtime == this.runtime &&
          other.image == this.image &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.releaseDate == this.releaseDate);
}

class DriftFilmCompanion extends UpdateCompanion<DriftFilmData> {
  final Value<int> id;
  final Value<double> popularity;
  final Value<int> runtime;
  final Value<String> image;
  final Value<String> title;
  final Value<String> overview;
  final Value<String> releaseDate;
  const DriftFilmCompanion({
    this.id = const Value.absent(),
    this.popularity = const Value.absent(),
    this.runtime = const Value.absent(),
    this.image = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.releaseDate = const Value.absent(),
  });
  DriftFilmCompanion.insert({
    this.id = const Value.absent(),
    required double popularity,
    required int runtime,
    required String image,
    required String title,
    required String overview,
    required String releaseDate,
  })  : popularity = Value(popularity),
        runtime = Value(runtime),
        image = Value(image),
        title = Value(title),
        overview = Value(overview),
        releaseDate = Value(releaseDate);
  static Insertable<DriftFilmData> custom({
    Expression<int>? id,
    Expression<double>? popularity,
    Expression<int>? runtime,
    Expression<String>? image,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? releaseDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (popularity != null) 'popularity': popularity,
      if (runtime != null) 'runtime': runtime,
      if (image != null) 'image': image,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (releaseDate != null) 'release_date': releaseDate,
    });
  }

  DriftFilmCompanion copyWith(
      {Value<int>? id,
      Value<double>? popularity,
      Value<int>? runtime,
      Value<String>? image,
      Value<String>? title,
      Value<String>? overview,
      Value<String>? releaseDate}) {
    return DriftFilmCompanion(
      id: id ?? this.id,
      popularity: popularity ?? this.popularity,
      runtime: runtime ?? this.runtime,
      image: image ?? this.image,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (runtime.present) {
      map['runtime'] = Variable<int>(runtime.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftFilmCompanion(')
          ..write('id: $id, ')
          ..write('popularity: $popularity, ')
          ..write('runtime: $runtime, ')
          ..write('image: $image, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }
}

class $DriftFilmTable extends DriftFilm
    with TableInfo<$DriftFilmTable, DriftFilmData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftFilmTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _popularityMeta = const VerificationMeta('popularity');
  @override
  late final GeneratedColumn<double?> popularity = GeneratedColumn<double?>(
      'popularity', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _runtimeMeta = const VerificationMeta('runtime');
  @override
  late final GeneratedColumn<int?> runtime = GeneratedColumn<int?>(
      'runtime', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String?> overview = GeneratedColumn<String?>(
      'overview', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String?> releaseDate = GeneratedColumn<String?>(
      'release_date', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, popularity, runtime, image, title, overview, releaseDate];
  @override
  String get aliasedName => _alias ?? 'drift_film';
  @override
  String get actualTableName => 'drift_film';
  @override
  VerificationContext validateIntegrity(Insertable<DriftFilmData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity']!, _popularityMeta));
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('runtime')) {
      context.handle(_runtimeMeta,
          runtime.isAcceptableOrUnknown(data['runtime']!, _runtimeMeta));
    } else if (isInserting) {
      context.missing(_runtimeMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftFilmData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DriftFilmData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DriftFilmTable createAlias(String alias) {
    return $DriftFilmTable(attachedDatabase, alias);
  }
}

abstract class _$FilmDatabase extends GeneratedDatabase {
  _$FilmDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DriftFilmTable driftFilm = $DriftFilmTable(this);
  late final FilmDao filmDao = FilmDao(this as FilmDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [driftFilm];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$FilmDaoMixin on DatabaseAccessor<FilmDatabase> {
  $DriftFilmTable get driftFilm => attachedDatabase.driftFilm;
}
