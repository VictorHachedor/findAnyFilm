import 'dart:math';

import 'package:flutter/services.dart';

import 'film_card.dart';
import 'film_details.dart';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../network/film_model.dart';
import '../network/film_service.dart';
import '../network/model_response.dart';
import '../data/models/data_models.dart';

class FilmList extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.filmListPath,
      key: ValueKey(FindAnyMoviesPages.filmListPath),
      child: const FilmList(),
    );
  }

  const FilmList({Key? key}) : super(key: key);

  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();

  List<APIResults> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false; // might be a problem
  bool loading = false;
  bool inErrorState = false;
  int page = 1;
  bool trigger = false;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.99 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (!loading && !inErrorState && trigger) {
          setState(() {
            loading = true;
            page += 1;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildFilmLoader(
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Search'),
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    controller: searchTextController,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      trigger = true;
      value = value.trim();
      page = 1;
    });
  }

  Widget _buildFilmLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    return FutureBuilder<Response<Result<APIFilmQuery>>>(
      future: FilmService.create().queryFilms(
        searchTextController.text.trim(),
        page,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString(),
                  textAlign: TextAlign.center, textScaleFactor: 1.3),
            );
          }
          loading = false;
          final result = snapshot.data?.body;
          if (result is Error) {
            inErrorState = true;
            return _buildFilmList(context, currentSearchList);
          }

          final query = (result as Success).value;
          inErrorState = false;
          trigger = true; // TODO need?
          currentSearchList.addAll(query.results);
          return _buildFilmList(context, currentSearchList);
        } else {
          if (currentSearchList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildFilmList(context, currentSearchList);
          }
        }
      },
    );
  }

  Widget _buildFilmList(
    BuildContext filmListContext,
    List<APIResults> results,
  ) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 310;
    final itemWidth = size.width / 2;

    return Flexible(
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20.0,
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFilmCard(filmListContext, results, index);
        },
      ),
    );
  }

  Widget _buildFilmCard(
    BuildContext topLevelContext,
    List<APIResults> results,
    int index,
  ) {
    final result = results[index];
    return GestureDetector(
      onTap: () {
        //TODO add navigator 2.0
        runtimeAndGenresWidget(topLevelContext, result);
         Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            final detailFilm = FilmModel(
              id: result.id,
              popularity: result.popularity,
              title: result.title,
              image: result.posterPath,
              overview: result.overview,
              releaseDate: result.releaseDate,
            );
            return FilmDetails(film: detailFilm); 
          },
        ));
      },
      child: filmCard(result),
    );
  }

  Widget runtimeAndGenresWidget(
    BuildContext topLevelContext,
    APIResults result,
  ) {
    return FutureBuilder<Response<Result<APIFilmDetailsQuery>>>(
        future: FilmDetailsService.create().queryFilmsDetails(result.id!),
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

            Navigator.push(topLevelContext, MaterialPageRoute(
              builder: (context) {
                final detailFilm = FilmModel(
                  //      id: result.id,
                  //      popularity: result.popularity,
                  //     title: result.title,
                  //      image: result.posterPath,
                  //      overview: result.overview,
                  //      releaseDate: result.releaseDate,
                  runtime: value.runtime,
                );
                return FilmDetails(film: detailFilm);
              },
            ));
          }
          print('555555555555555555555555555555');
          return Text('');
        });
  }
}
