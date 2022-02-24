import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

import 'package:chopper/chopper.dart';
import '../network/film_model.dart';
import '../network/film_service.dart';
import '../network/model_response.dart';
import '../data/models/data_models.dart';

class FilmDetails extends StatefulWidget {
  /*  MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.filmDetailsPath,
      key: ValueKey(FindAnyMoviesPages.filmDetailsPath),
      child: FilmDetails(film: film,),
    );
  }*/

  const FilmDetails({Key? key, required this.film}) : super(key: key);
  final FilmModel film;

  @override
  _FilmDetailsState createState() => _FilmDetailsState(film); //stateless?
}

class _FilmDetailsState extends State<FilmDetails> {
  final FilmModel film;

  _FilmDetailsState(this.film);

  @override
  Widget build(BuildContext context) {
    const String imageBaseUrl =
        'https://www.themoviedb.org/t/p/w300_and_h450_bestv2';
    final repository = Provider.of<MemoryRepository>(context);
    final size = MediaQuery.of(context).size;
    SavedFilmModel savedFilm;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CachedNetworkImage(
                        // TODO 1
                        imageUrl: imageBaseUrl + (film.image ?? ''),
                        // 'https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg',
                        alignment: Alignment.topLeft,
                        fit: BoxFit.fill,
                        width: size.width,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: BackButton(
                          color: Colors.white,
                          onPressed: () {
                            Provider.of<AppStateManager>(context, listen: false)
                                .tapOnCard(false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    // TODO 2
                    film.title ?? '',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
                    label: Text(film.releaseDate ?? ''),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
                    label: runtimeAndGenresWidget(film, 'runtime', null),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: runtimeAndGenresWidget(film, null, 'genres'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text('Cast and Crew'),
                const SizedBox(
                  height: 8,
                ),
                Text('Directors'),
                crewAndCastWidget(film, 'directors', null),
                const SizedBox(
                  height: 8,
                ),
                Text('Cast'),
                crewAndCastWidget(film, null, 'actors'),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                    ),
                    onPressed: () {
                      
                        repository.insertFilm(SavedFilmModel(
                          id: film.id ?? 0,
                          image: film.image ?? '',
                          title: film.title ?? '',
                          runtime: film.runtime,
                          popularity: film.popularity ?? 0.0));
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icon_bookmark.svg',
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Bookmark',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget runtimeAndGenresWidget(
      FilmModel film, String? runtimeMark, String? genresMark) {
    return FutureBuilder<Response<Result<APIFilmDetailsQuery>>>(
        future: FilmDetailsService.create().queryFilmsDetails(film.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    textAlign: TextAlign.center, textScaleFactor: 1.3),
              );
            }

            final result = snapshot.data?.body;
            if (result is Error) {
              const Text('result is Error');
            }

            final value = (result as Success).value;

            if (genresMark != null) {
              final genres = value.genres;
              List<APIGenre> genresList = genres;
              List<String?> genresNames = [];
              for (var i = 0; i < genresList.length; i++) {
                genresNames.add(genresList[i].genreName);
              }
              final genresString = genresNames.join(', ');
              return Container(
                height: (23.0 * genresList.length),
                child: Text(genresString,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              );
            } else if (runtimeMark != null) {
              final savedFilm = SavedFilmModel();
              final runtime = value.runtime;
              savedFilm.runtime = runtime;
              return Text('${runtime ?? 'Unknown'}');
            }
          }
          return Text('Errorr runtimeWidgeteee');
        });
  }

  Widget crewAndCastWidget(
      FilmModel film, String? directorsMark, String? actorsMark) {
    return FutureBuilder<Response<Result<APICreditsQuery>>>(
        future: FilmsCastService.create().queryFilmsCast(film.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    textAlign: TextAlign.center, textScaleFactor: 1.3),
              );
            }

            final result = snapshot.data?.body;
            if (result is Error) {
              const Text('result is Error');
            }
            final value = (result as Success).value;

            if (directorsMark != null) {
              List<APICrew> crew = value.crew;
              List directors = [];
              for (var i = 0; i < crew.length; i++) {
                if (crew[i].job == 'Director') {
                  directors.add(crew[i].crewMemberName);
                }
              }
              if (directors.isNotEmpty) {
                return SizedBox(
                  height: 44.0,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 180,
                      childAspectRatio: 7,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: directors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            directors[index],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Text('Unknown');
              }
            } else if (actorsMark != null) {
              List<APICast> cast = value.cast;
              List actorsNames = [];
              for (final castMember in cast) {
                actorsNames.add(castMember.actorsName);
              }
              if (actorsNames.isNotEmpty) {
                return SizedBox(
                  height: 44,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 180,
                      childAspectRatio: 7,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: actorsNames.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          actorsNames[index],
                          overflow: TextOverflow.ellipsis,
                        )),
                      );
                    },
                  ),
                );
              } else {
                const Text('Unknown');
              }
            }
          }
          return const Text('Unknown');
        });
  }

  Widget filmDetailsWidget(
      FilmModel film,
      // String? runtimeMark,
      //   String? genresMark,
      MemoryRepository repository) {
    return FutureBuilder<Response<Result<APIFilmDetailsQuery>>>(
        future: FilmDetailsService.create().queryFilmsDetails(film.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    textAlign: TextAlign.center, textScaleFactor: 1.3),
              );
            }

            final result = snapshot.data?.body;
            if (result is Error) {
              const Text('result is Error');
            }

            final value = (result as Success).value;
            //   List filmDetails = value;
            //     filmDetails[0].runtime;
            return insertFilm(repository, value);
            /*    if (genresMark != null) {
              final genres = value.genres;
              List<APIGenre> genresList = genres;
              List<String?> genresNames = [];
              for (var i = 0; i < genresList.length; i++) {
                genresNames.add(genresList[i].genreName);
              }
              final genresString = genresNames.join(', ');
              return Container(
                height: (23.0 * genresList.length),
                child: Text(genresString,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              );
            } else if (runtimeMark != null) {
              final savedFilm = SavedFilmModel();
              final runtime = value.runtime;
              savedFilm.runtime = runtime;
              return Text('${runtime ?? 'Unknown'}');
            }*/
          }
          return Text('Errorr runtimeWidgeteee');
        });
  }

  Widget insertFilm(MemoryRepository repository, dynamic value) {
    repository.insertFilm(SavedFilmModel(
      //   id: value.id,
      // image: value.image,
      // title: value.title,
      runtime: value.runtime,
      // popularity: value.popularity
    ));
    return Text('');
  }
}

/*class GetRuntime {
  int? runtime;
  Widget runtimeAndGenresWidget(
      FilmModel film, String? runtimeMark, String? genresMark) {
    int runtime;
    return FutureBuilder<Response<Result<APIFilmDetailsQuery>>>(
        future: FilmDetailsService.create().queryFilmsDetails(film.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    textAlign: TextAlign.center, textScaleFactor: 1.3),
              );
            }

            final result = snapshot.data?.body;
            if (result is Error) {
              const Text('result is Error');
            }

            final value = (result as Success).value;

            if (genresMark != null) {
              final genres = value.genres;
              List<APIGenre> genresList = genres;
              List<String?> genresNames = [];
              for (var i = 0; i < genresList.length; i++) {
                genresNames.add(genresList[i].genreName);
              }
              final genresString = genresNames.join(', ');
              return Container(
                height: (23.0 * genresList.length),
                child: Text(genresString,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              );
            } else if (runtimeMark != null) {
              runtime = value.runtime;

              return Text('${runtime}');
            }
          }
          return Text('Errorr runtimeWidgeteee');
        });
  }

  Future<SavedFilmModel?> fetchRuntime(FilmModel film) async {
    try {
      final result =
          await FilmDetailsService.create().queryFilmsDetails(film.id!);
      final body = result.body;
      final asdfs = (body as Success).value;
      int runtime = asdfs.runtime;
      return SavedFilmModel(
        runtime: runtime,
      );
    } catch (e) {
      print(e);
    }
    return Future.value();
  }

  SavedFilmModel runtimeFunction(FilmModel film) {
    final runtime = fetchRuntime(film);

    return SavedFilmModel(
      runtime: 0,
    );
  }
}*/
