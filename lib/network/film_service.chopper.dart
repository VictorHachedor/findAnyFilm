// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$FilmService extends FilmService {
  _$FilmService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FilmService;

  @override
  Future<Response<Result<APIFilmQuery>>> queryFilms(String query, int? page) {
    final $url = '/search/movie?';
    final $params = <String, dynamic>{'query': query, 'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result<APIFilmQuery>, APIFilmQuery>($request);
  }
}

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$FilmDetailsService extends FilmDetailsService {
  _$FilmDetailsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FilmDetailsService;

  @override
  Future<Response<Result<APIFilmDetailsQuery>>> queryFilmsDetails(int movieId) {
    final $url = '/movie/${movieId}?append_to_response=videos,credits';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<Result<APIFilmDetailsQuery>, APIFilmDetailsQuery>($request);
  }
}

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$InCinemaService extends InCinemaService {
  _$InCinemaService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = InCinemaService;

  @override
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryInCinema() {
    final $url = '/movie/now_playing?';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Result<APINewsScreenFilmsQuery>,
        APINewsScreenFilmsQuery>($request);
  }
}

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$WatchNowService extends WatchNowService {
  _$WatchNowService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WatchNowService;

  @override
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryWatchNow() {
    final $url = '/movie/popular?';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Result<APINewsScreenFilmsQuery>,
        APINewsScreenFilmsQuery>($request);
  }
}

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$CommingSoonService extends CommingSoonService {
  _$CommingSoonService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CommingSoonService;

  @override
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryCommingSoon() {
    final $url = '/movie/upcoming?';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Result<APINewsScreenFilmsQuery>,
        APINewsScreenFilmsQuery>($request);
  }
}

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TopRatedService extends TopRatedService {
  _$TopRatedService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TopRatedService;

  @override
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryTopRated() {
    final $url = '/movie/top_rated?';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Result<APINewsScreenFilmsQuery>,
        APINewsScreenFilmsQuery>($request);
  }
}
