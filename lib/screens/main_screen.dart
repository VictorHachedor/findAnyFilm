import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'screens.dart';

class MainScreen extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FindAnyMoviesPages.mainPage,
      key: ValueKey(FindAnyMoviesPages.mainPage),
      child: MainScreen(currentTab: currentTab),
    );
  }

  const MainScreen({Key? key, required this.currentTab}) : super(key: key);

  final int currentTab;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static List<Widget> pages = <Widget>[
    NewsScreen(),
    FilmList(),
    //TODO add Series screen
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (
      context,
      appStateManager,
      child,
    ) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Find Any Film',
              style: TextStyle(
                fontSize: 23,
              )),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: widget.currentTab,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.lightGreen,
          currentIndex: widget.currentTab,
          onTap: (index) {
            Provider.of<AppStateManager>(context, listen: false).goToTab(index);
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.aod),
              label: 'News',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Films',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.circle),
              label: 'Series',
            ),
          ],
        ),
      );
    });
  }
}
