import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[];

  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pages.add(const NewsScreen());
    pages.add(const FilmList());
    pages.add(const WatchlistScreen());
    _getCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FilmTheme.backgroundColor,
        title: const Text('Find Any Film',
            style: TextStyle(
              fontSize: 23,
            )),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(

        unselectedItemColor: Colors.white,
        backgroundColor: FilmTheme.backgroundColor,
        selectedItemColor: FilmTheme.acidGreenColor,
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }

  void _saveCurrentIndex() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void _getCurrentIndex() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = preferences.getInt(prefSelectedIndexKey);
        if (index != null) {
          _selectedIndex = index;
        }
      });
    }
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    _saveCurrentIndex();
  }
}
