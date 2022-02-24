import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/data/models/data_models.dart';
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
    const String imageBaseUrl =
        'https://www.themoviedb.org/t/p/w300_and_h450_bestv2';
    return Consumer<MemoryRepository>(
      builder: (context, repository, child) {
        savedFilms = repository.findAllFilms();
        return ListView.builder(
          itemCount: savedFilms.length,
          itemBuilder: (context, index) {
            final savedFilm = savedFilms[index];
            return SizedBox(
              height: 100,
              child: Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
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
                            imageUrl: imageBaseUrl + (savedFilm.image ?? ''),
                            height: 120,
                            width: 60,
                            fit: BoxFit.cover),
                        isThreeLine: true,
                        title: Text(savedFilm.title ?? ' '),
                        subtitle: Row(children: [
                          Icon(Icons.arrow_circle_up, color: Colors.green),
                          Text('${savedFilm.popularity ?? ' '}'),

                        ],),
                        trailing: Text('${savedFilm.runtime ?? ' '}'),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                      caption: 'Delete',
                      color: Colors.transparent,
                      foregroundColor: Colors.black,
                      iconWidget: const Icon(Icons.delete, color: Colors.red),
                      onTap: () => deleteSavedFilm(repository, savedFilm)),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Delete',
                      color: Colors.transparent,
                      foregroundColor: Colors.black,
                      iconWidget: const Icon(Icons.delete, color: Colors.red),
                      onTap: () => deleteSavedFilm(repository, savedFilm)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void deleteSavedFilm(
    MemoryRepository repository, SavedFilmModel savedFilm) async {
  if (savedFilm.id != null) {
    repository.deleteSavedFilm(savedFilm);
 //   setState(() {});
  } else{
    print('Recipe id is null');
  }
}
