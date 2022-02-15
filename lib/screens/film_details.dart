import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class FilmDetails extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.filmDetailsPath,
      key: ValueKey(FindAnyMoviesPages.filmDetailsPath),
      child: const FilmDetails(),
    );
  }

  const FilmDetails({Key? key}) : super(key: key);

  @override
  _FilmDetailsState createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                        imageUrl:
                            'https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg',
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
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    // TODO 2
                    'Chicken Vesuvio',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Chip(
                      // TODO 3
                      label: Text('16CAL'),
                    )),
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
                      // TODO 4
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
}
