import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';
import 'package:find_any_movie/data/repository.dart';
import 'package:find_any_movie/screens/screens.dart';
import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart';
import '../network/film_model.dart';
import '../network/film_service.dart';
import '../network/model_response.dart';
import '../data/models/data_models.dart';

class FilmDetails extends StatelessWidget {
  const FilmDetails({Key? key, required this.film}) : super(key: key);
  final FilmModel film;
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: FilmTheme.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CachedNetworkImage(
                        imageUrl: GetImageUrl.imageUrl(film.image ?? ''),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/default-image.jpg'),
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Center(
                    child: Text(                 
                      film.title ?? '',
                      style: FilmTheme.textTheme.headline1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: Row(
                        children: [
                          Material(
                            type: MaterialType.circle,
                            clipBehavior: Clip.antiAlias,
                            color: FilmTheme.backgroundColor,
                            child: IconButton(
                                icon: const Icon(
                                  Icons.bookmark_border,
                                  color: FilmTheme.acidGreenColor,
                                ),
                                onPressed: () {
                                  repository.insertSavedFilm(SavedFilmModel(
                                      id: film.id ?? 0,
                                      image: film.image ?? '',
                                      title: film.title ?? '',
                                      runtime: film.runtime ?? 0,
                                      popularity: film.popularity ?? 0.0));
                                  Navigator.pop(context);
                                },
                                splashRadius: 30.0,
                                splashColor: FilmTheme.acidGreenColor),
                          ),
                          Text('Save', style: FilmTheme.textTheme.bodyText1),
                        ],
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      film.youtubeKey != ''
                          ? SizedBox(
                              child: Row(children: [
                              Material(
                                type: MaterialType.circle,
                                clipBehavior: Clip.antiAlias,
                                color: FilmTheme.backgroundColor,
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.play_arrow_outlined,
                                      size: 34,
                                      color: FilmTheme.acidGreenColor,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return TrailerScreen(
                                            youtubeKey: film.youtubeKey);
                                      }));
                                    },
                                    splashRadius: 30.0,
                                    splashColor: FilmTheme.acidGreenColor),
                              ),
                              Text('Videos',
                                  style: FilmTheme.textTheme.bodyText1),
                            ]))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            releaseDateTransformer(),
                            Text('  •  ${film.runtime}min',
                                style: FilmTheme.textTheme.bodyText2),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        genresWidget(film),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          '${film.overview}',
                          style: FilmTheme.textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text('Cast & Crew',
                            style: FilmTheme.textTheme.headline2),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Directors', style: FilmTheme.textTheme.bodyText2),
                        const SizedBox(
                          height: 16,
                        ),
                       buildCrew(film.crew),
                     
                        const SizedBox(
                          height: 33,
                        ),
                        Text('Cast', style: FilmTheme.textTheme.bodyText2),
                        const SizedBox(
                          height: 16,
                        ),
                      buildCast(film.cast),
                     
                        const SizedBox(
                          height: 64,
                        ),
                        Center(
                          child: SvgPicture.asset('assets/tmdb_blue_short.svg',
                              color: const Color.fromRGBO(1, 180, 228, 0.9)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget genresWidget(FilmModel film) {
    final genres = film.genres;
    List<APIGenre>? genresList = genres;
    List<String?> genresNames = [];
    for (var i = 0; i < genresList!.length; i++) {
      genresNames.add(genresList[i].genreName);
    }
    final genresString = genresNames.join('     ');
    return Text(genresString, style: FilmTheme.textTheme.bodyText2);
  }

  Widget releaseDateTransformer() {
    final date = film.releaseDate;
    final String year = (date ?? '').substring(0, 4);
    final String month = (date ?? '').substring(5, 7);
    final String day = (date ?? '').substring(8, 10);
    List newDate = [
      day,
      month,
      year,
    ];
    return Text(
      newDate.join('/'),
      style: FilmTheme.textTheme.bodyText2,
    );
  }

  Widget buildCrew(List<APICrew>? crew) {
    List directors = [];
    for (var i = 0; i < crew!.length; i++) {
      if (crew[i].job == 'Director') {
        directors.add(crew[i].crewMemberName);
      }
    }
    if (directors.isNotEmpty) {
      return SizedBox(
        height: 44.0,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                color: FilmTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  directors[index],
                  overflow: TextOverflow.ellipsis,
                  style: FilmTheme.textTheme.bodyText2,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Text(
        'Unknown',
        style: FilmTheme.textTheme.bodyText2,
      );
    }
  }

  Widget buildCast(List<APICast>? cast) {
    List actorsNames = [];
    for (final castMember in cast!) {
      actorsNames.add(castMember.actorsName);
    }
    if (actorsNames.isNotEmpty) {
      return SizedBox(
        height: 44,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                color: FilmTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Center(
                  child: Text(
                actorsNames[index],
                overflow: TextOverflow.ellipsis,
                style: FilmTheme.textTheme.bodyText2,
              )),
            );
          },
        ),
      );
    } 
    return Text(
        'Unknown',
        style: FilmTheme.textTheme.bodyText2,
      );
    
  }
}
