import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';
import 'package:find_any_movie/data/repository.dart';
import 'package:find_any_movie/network/film_service.dart';
import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<SavedFilmModel> savedFilms = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FilmTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildSavedFilmsList(context),
      ),
    );
  }

  Widget _buildSavedFilmsList(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<List<SavedFilmModel>>(
      stream: repository.watchAllSavedFilms(),
      builder: (context, AsyncSnapshot<List<SavedFilmModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final savedFilms = snapshot.data ?? [];
          return ListView.builder(
            itemCount: savedFilms.length,
            itemBuilder: (context, index) {
              final savedFilm = savedFilms[index];
              return SizedBox(
                  height: 100,
                  width: 300,
                  child: Slidable(
                    child: Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            style: BorderStyle.solid, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: FilmTheme.backgroundColor,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                              child: CachedNetworkImage(
                                  imageUrl: GetImageUrl.imageUrl(
                                      savedFilm.image ?? ''),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/default-image.jpg'),
                                  height: 120,
                                  width: 60,
                                  fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    savedFilm.title ?? ' ',
                                    style: FilmTheme.textTheme.subtitle2,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        'User Score: ',
                                        style: FilmTheme.textTheme.subtitle2,
                                      ),
                                      savedFilm.popularity! >= 5.0 ?  
                                      const Icon(
                                        Icons.arrow_upward,
                                        color: Colors.green,
                                        size: 15,
                                      ) : const Icon(
                                        Icons.arrow_downward,
                                        color: Colors.purple,
                                        size: 15,
                                      ),
                                      Text(
                                        '${(savedFilm.popularity! * 10)}%',
                                        style: FilmTheme.textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${savedFilm.runtime ?? ' '} min',
                                    style: FilmTheme.textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    startActionPane: ActionPane(
                        extentRatio: 0.25,
                        dragDismissible: false,
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                deleteSavedFilm(repository, savedFilm),
                            foregroundColor: Colors.red,
                            backgroundColor: FilmTheme.backgroundColor,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ]),
                    endActionPane: ActionPane(
                        extentRatio: 0.25,
                        dragDismissible: false,
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                deleteSavedFilm(repository, savedFilm),
                            foregroundColor: Colors.red,
                            backgroundColor: FilmTheme.backgroundColor,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ]),
                  ));
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

void deleteSavedFilm(Repository repository, SavedFilmModel savedFilm) async {
  if (savedFilm.id != null) {
    await repository.deleteSavedFilm(savedFilm);
  } else {
    print('Recipe id is null');
  }
}
