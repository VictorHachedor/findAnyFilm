// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$FilmService extends FilmService {
  _$FilmService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FilmService;

  @override
  Future<Response<Result<APIFilmQuery>>> queryFilms(String query, int? page) {
    final $url = '?';
    final $params = <String, dynamic>{'query': query, 'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result<APIFilmQuery>, APIFilmQuery>($request);
  }
}
