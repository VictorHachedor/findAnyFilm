import 'package:flutter/material.dart';
import '../models/models.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.mainPage,
      key: ValueKey(FindAnyMoviesPages.mainPage),
      child: const MainScreen(),
    );
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: TextButton(
                child: const Text('back to sign up'),
                onPressed: () { 
                 

                })),
      ),
    );
  }
}
