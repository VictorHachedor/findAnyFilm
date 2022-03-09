import 'package:chopper/chopper.dart';
import 'film_model.dart';
import 'model_response.dart';
import 'model_converter.dart';

part 'film_service.chopper.dart';

const String apiKey = 'ca907ef19d5ba9c507df9ed359b28378';
const String apiUrl = 'https://api.themoviedb.org/3';

class GetImageUrl {
  static const _imageUrl =
      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2';
  static String imageUrl(String imagePath) => _imageUrl + imagePath;
}

@ChopperApi()
abstract class FilmService extends ChopperService {
  @Get(path: '/search/movie?')
  Future<Response<Result<APIFilmQuery>>> queryFilms(
    @Query('query') String query,
    @Query('page') int? page,
  );
  static FilmService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$FilmService(),
      ],
    );
    return _$FilmService(client);
  }
}

@ChopperApi()
abstract class FilmDetailsService extends ChopperService {
  @Get(path: '/movie/{movieId}?append_to_response=videos,credits')
  Future<Response<Result<APIFilmDetailsQuery>>> queryFilmsDetails(
      @Path('movieId') int movieId,);

  static FilmDetailsService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: FilmDetailsModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$FilmDetailsService(),
      ],
    );
    return _$FilmDetailsService(client);
  }
}

@ChopperApi()
abstract class InCinemaService extends ChopperService {
  @Get(path: '/movie/now_playing?')
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryInCinema();

  static InCinemaService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: NewsScreenFilmsModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$InCinemaService(),
      ],
    );
    return _$InCinemaService(client);
  }
}

@ChopperApi()
abstract class WatchNowService extends ChopperService {
  @Get(path: '/movie/popular?')
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryWatchNow();

  static WatchNowService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: NewsScreenFilmsModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$WatchNowService(),
      ],
    );
    return _$WatchNowService(client);
  }
}

@ChopperApi()
abstract class CommingSoonService extends ChopperService {
  @Get(path: '/movie/upcoming?')
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryCommingSoon();

  static CommingSoonService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: NewsScreenFilmsModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$CommingSoonService(),
      ],
    );
    return _$CommingSoonService(client);
  }
}

@ChopperApi()
abstract class TopRatedService extends ChopperService {
  @Get(path: '/movie/top_rated?')
  Future<Response<Result<APINewsScreenFilmsQuery>>> queryTopRated();

  static TopRatedService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: NewsScreenFilmsModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$TopRatedService(),
      ],
    );
    return _$TopRatedService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['api_key'] = apiKey;
  return req.copyWith(parameters: params);
}
