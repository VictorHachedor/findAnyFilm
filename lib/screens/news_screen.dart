import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:find_any_movie/network/film_model.dart';
import 'package:find_any_movie/screens/film_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../data/models/data_models.dart';
import '../main.dart';
import '../network/film_service.dart';
import '../network/model_response.dart';
import '../themes.dart';
import 'screens.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool loading = false;
  bool inErrorState = false;
  List<APINewsScreenFilmsResults> inCinemaList = [];
  List<APINewsScreenFilmsResults> watchNowList = [];
  List<APINewsScreenFilmsResults> commingSoonList = [];
  List<APINewsScreenFilmsResults> topRatedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FilmTheme.backgroundColor,
        body: SafeArea(
            child: RefreshIndicator(
          color: FilmTheme.acidGreenColor,
          backgroundColor: FilmTheme.backgroundColor,
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              (() => setState(() {})),
            );
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: const TestSlider(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('In cinemas', style: FilmTheme.textTheme.headline3),
                    buildInCinema(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Watch now', style: FilmTheme.textTheme.headline3),
                    buildWatchNow(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Comming Soon', style: FilmTheme.textTheme.headline3),
                    buildCommingSoon(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Top Rated', style: FilmTheme.textTheme.headline3),
                    buildTopRated(),
                    const SizedBox(
                      height: 64,
                    ),
                    Center(
                      child: SvgPicture.asset(
                          'assets/tmdb_blue_short_nostyle.svg',
                          color: const Color.fromRGBO(1, 180, 228, 0.9)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  Widget buildInCinema() {
    return FutureBuilder<Response<Result<APINewsScreenFilmsQuery>>>(
        future: InCinemaService.create().queryInCinema(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              if (error.toString().contains('SocketException:')) {
                return Text(
                  'Please check your internet connection.',
                  style: FilmTheme.textTheme.headline4,
                );
              }
              return Text(
                'Please reload the application.',
                style: FilmTheme.textTheme.headline4,
              );
            }
            loading = false;
            final result = snapshot.data?.body;
            if (result is Error) {
              inErrorState = true;
              return _buildFilmList(context, inCinemaList);
            }
            final query = (result as Success).value;
            inErrorState = false;
            inCinemaList.clear();
            inCinemaList.addAll(query.results);
            return _buildFilmList(context, inCinemaList);
          } else {
            if (inCinemaList.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: FilmTheme.acidGreenColor));
            } else {
              return _buildFilmList(context, inCinemaList);
            }
          }
        });
  }

  Widget buildWatchNow() {
    return FutureBuilder<Response<Result<APINewsScreenFilmsQuery>>>(
        future: WatchNowService.create().queryWatchNow(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              if (error.toString().contains('SocketException:')) {
                return Text(
                  'Please check your internet connection.',
                  style: FilmTheme.textTheme.headline4,
                );
              }
              return Text(
                'Please reload the application.',
                style: FilmTheme.textTheme.headline4,
              );
            }
            loading = false;
            final result = snapshot.data?.body;
            if (result is Error) {
              inErrorState = true;
              return _buildFilmList(context, watchNowList);
            }
            final query = (result as Success).value;
            inErrorState = false;
            watchNowList.clear();
            watchNowList.addAll(query.results);
            return _buildFilmList(context, watchNowList);
          } else {
            if (watchNowList.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: FilmTheme.acidGreenColor));
            } else {
              return _buildFilmList(context, watchNowList);
            }
          }
        });
  }

  Widget buildCommingSoon() {
    return FutureBuilder<Response<Result<APINewsScreenFilmsQuery>>>(
        future: CommingSoonService.create().queryCommingSoon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              if (error.toString().contains('SocketException:')) {
                return Text(
                  'Please check your internet connection.',
                  style: FilmTheme.textTheme.headline4,
                );
              }
              return Text(
                'Please reload the application.',
                style: FilmTheme.textTheme.headline4,
              );
            }
            loading = false;
            final result = snapshot.data?.body;
            if (result is Error) {
              inErrorState = true;
              return _buildFilmList(context, commingSoonList);
            }
            final query = (result as Success).value;
            inErrorState = false;
            commingSoonList.clear();
            commingSoonList.addAll(query.results);
            return _buildFilmList(context, commingSoonList);
          } else {
            if (commingSoonList.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: FilmTheme.acidGreenColor));
            } else {
              return _buildFilmList(context, commingSoonList);
            }
          }
        });
  }

  Widget buildTopRated() {
    return FutureBuilder<Response<Result<APINewsScreenFilmsQuery>>>(
        future: TopRatedService.create().queryTopRated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              if (error.toString().contains('SocketException:')) {
                return Text(
                  'Please check your internet connection.',
                  style: FilmTheme.textTheme.headline4,
                );
              }
              return Text(
                'Please reload the application.',
                style: FilmTheme.textTheme.headline4,
              );
            }
            loading = false;
            final result = snapshot.data?.body;
            if (result is Error) {
              inErrorState = true;
              return _buildFilmList(context, topRatedList);
            }
            final query = (result as Success).value;
            inErrorState = false;
            topRatedList.clear();
            topRatedList.addAll(query.results);
            return _buildFilmList(context, topRatedList);
          } else {
            if (topRatedList.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: FilmTheme.acidGreenColor));
            } else {
              return _buildFilmList(context, topRatedList);
            }
          }
        });
  }

  Widget _buildFilmList(
    BuildContext filmListContext,
    List<APINewsScreenFilmsResults> results,
  ) {
    return LimitedBox(
      maxHeight: 300,
      //  Flexible(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2.0,
          crossAxisCount: 1,
          childAspectRatio: 1.8,
        ),
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFilmCard(filmListContext, results, index);
        },
      ),
      //  );
    );
  }

  Widget _buildFilmCard(
    BuildContext topLevelContext,
    List<APINewsScreenFilmsResults> results,
    int index,
  ) {
    final result = results[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            return FutureBuilder<Response<Result<APIFilmDetailsQuery>>>(
                future: FilmDetailsService.create()
                    .queryFilmsDetails(result.id ?? 0),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      if (error.toString().contains('SocketException:')) {
                        return Scaffold(
                            appBar: AppBar(
                              backgroundColor: FilmTheme.backgroundColor,
                              title: const Text('Find Any Film',
                                  style: TextStyle(
                                    fontSize: 23,
                                  )),
                              centerTitle: true,
                            ),
                            backgroundColor: FilmTheme.backgroundColor,
                            body: Center(
                              child: Text(
                                'Please check your internet connection.',
                                style: FilmTheme.textTheme.headline4,
                              ),
                            ));
                      }
                      return Scaffold(
                          appBar: AppBar(
                            backgroundColor: FilmTheme.backgroundColor,
                            title: const Text('Find Any Film',
                                style: TextStyle(
                                  fontSize: 23,
                                )),
                            centerTitle: true,
                          ),
                          backgroundColor: FilmTheme.backgroundColor,
                          body: Center(
                            child: Text(
                              'Please reload the application.',
                              style: FilmTheme.textTheme.headline4,
                            ),
                          ));
                    }

                    final result = snapshot.data?.body;
                    if (result is Error) {
                      const Text('result is Error');
                    }

                    final value = (result as Success).value;

                    final List<APITrailer>? videos = value.videos.results;
                    final youTubeTrailers = videos?.where(
                      (trailer) =>
                          trailer.site == 'YouTube' &&
                          trailer.type == 'Trailer',
                    );
                    final trailer = youTubeTrailers!.isNotEmpty
                        ? youTubeTrailers.first
                        : null;
                    final List<APICast>? cast = value.credits.cast;
                    final List<APICrew>? crew = value.credits.crew;

                    final detailFilm = FilmModel(
                      id: value.id,
                      popularity: value.voteAverage,
                      title: value.title,
                      image: value.image,
                      overview: value.overview,
                      releaseDate: value.releaseDate,
                      runtime: value.runtime,
                      genres: value.genres,
                      youtubeKey: trailer?.key ?? '',
                      cast: cast ?? [],
                      crew: crew ?? [],
                    );

                    return FilmDetails(film: detailFilm);
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                          color: FilmTheme.acidGreenColor));
                });
          },
        ));
      },
      child: newsScreenFilmCard(result),
    );
  }
}
