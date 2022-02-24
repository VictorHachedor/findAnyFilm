import 'package:chopper/chopper.dart';
import 'film_model.dart';
import 'model_response.dart';
import 'model_converter.dart';

part 'film_service.chopper.dart';

const String apiKey = 'ca907ef19d5ba9c507df9ed359b28378';
const String apiUrl = 'https://api.themoviedb.org/3';

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
  @Get(path: '/movie/{movieId}?')
  Future<Response<Result<APIFilmDetailsQuery>>> queryFilmsDetails(
    @Path('movieId') int movieId
    );

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
abstract class FilmsCastService extends ChopperService {
  @Get(path: '/movie/{movieId}/credits?')
  Future<Response<Result<APICreditsQuery>>> queryFilmsCast(
    @Path('movieId') int movieId
    );

  static FilmsCastService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: FilmsCreditsModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$FilmsCastService(),
      ],
    );
    return _$FilmsCastService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['api_key'] = apiKey;
  return req.copyWith(parameters: params);
}
