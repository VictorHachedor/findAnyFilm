import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';
import 'package:find_any_movie/data/repository.dart';
import 'package:find_any_movie/network/film_service.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildSavedFilmsList(context),
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
                  child: Slidable(
                    child: Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CachedNetworkImage(
                                imageUrl:
                                    GetImageUrl.imageUrl(savedFilm.image ?? ''),
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/default-image.jpg'),
                                height: 120,
                                width: 60,
                                fit: BoxFit.cover),
                            isThreeLine: true,
                            title: Text(savedFilm.title ?? ' '),
                            subtitle: Row(
                              children: [
                                const Text('User Score: '),
                                const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 15,
                                ),
                                Text('${(savedFilm.popularity! * 10)}%'),
                              ],
                            ),
                            trailing: Text('${savedFilm.runtime ?? ' '}'),
                          ),
                        ),
                      ),
                    ),
                    startActionPane: ActionPane(
                        dragDismissible: false,
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                deleteSavedFilm(repository, savedFilm),
                            foregroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ]),
                    endActionPane: ActionPane(
                        dragDismissible: false,
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                deleteSavedFilm(repository, savedFilm),
                            foregroundColor: Colors.red,
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

void deleteSavedFilm(
    Repository repository, SavedFilmModel savedFilm) async {
  if (savedFilm.id != null) {
    await repository.deleteSavedFilm(savedFilm);
  } else {
    print('Recipe id is null');
  }
}
