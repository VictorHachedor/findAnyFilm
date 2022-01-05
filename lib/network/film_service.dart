import 'package:chopper/chopper.dart';
import 'film_model.dart';
import 'model_response.dart';
import 'model_converter.dart';

part 'film_service.chopper.dart';

const String apiKey = 'ca907ef19d5ba9c507df9ed359b28378';
const String apiUrl = 'https://api.themoviedb.org/3/search/movie';

@ChopperApi()
abstract class FilmService extends ChopperService {
  @Get(path: '?')
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

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['api_key'] = apiKey;
  return req.copyWith(parameters: params);
}
