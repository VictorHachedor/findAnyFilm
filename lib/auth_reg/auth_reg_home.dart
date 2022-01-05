import 'package:flutter/material.dart';
import '../models/models.dart';
import 'sign_up.dart';
import 'auth.dart';

class AuthRegHome extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.authRegHomePath,
      key: ValueKey(FindAnyMoviesPages.authRegHomePath),
      child: const AuthRegHome(),
    );
  }

  const AuthRegHome({Key? key}) : super(key: key);

  @override
  _AuthRegHomeState createState() => _AuthRegHomeState();
}

class _AuthRegHomeState extends State<AuthRegHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10.0,
          elevation: 0.0,
          backgroundColor: const Color.fromRGBO(6, 10, 20, 0.9),
          bottom: const TabBar(
            //TODO maybe get rid of splash
            unselectedLabelColor: Colors.grey,
            labelColor: Color.fromRGBO(120, 240, 120, 1.0),
            labelStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
            indicatorColor: Color.fromARGB(0, 6, 10, 20),
            tabs: <Widget>[Tab(text: 'Login'), Tab(text: 'Sign Up')],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            AuthWidget(),
            SignupWidget(),
          ],
        ),
      ),
    );
  }
}
