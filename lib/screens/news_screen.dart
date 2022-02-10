import 'package:find_any_movie/screens/film_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'screens.dart';
import 'package:chopper/chopper.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.newsPath,
      key: ValueKey(FindAnyMoviesPages.newsPath),
      child: const NewsScreen(),
    );
  }

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final cards = [
    Container(
      width: 200,
      height: 200,
      color: Colors.green,
    ),
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    Container(width: 200, height: 200, color: Colors.yellow),
    Container(width: 200, height: 200, color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
              SizedBox(
                height: 300,
             width: MediaQuery.of(context).size.width,
             child: TestSlider(),
           ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('In cinemas',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  Container(
                      height: 200,
                      color: Colors.transparent,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildCard(index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                        itemCount: 4,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Watch now',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  Container(
                      height: 200,
                      color: Colors.transparent,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildCard(index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                        itemCount: 4,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Collections',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  Container(
                      height: 200,
                      color: Colors.transparent,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildCard(index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                        itemCount: 4,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Twitter',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  Container(
                      height: 200,
                      color: Colors.transparent,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildCard(index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                        itemCount: 4,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    color: Colors.blue[800],
                    child: Text('Footer'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    return GestureDetector(
      onTap: () {
        Provider.of<AppStateManager>(context, listen: false).tapOnCard(true);
      },
      child: cards[index],
    );
  }
}
