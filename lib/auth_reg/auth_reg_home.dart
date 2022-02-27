import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'auth.dart';

class AuthRegHome extends StatefulWidget {

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
          backgroundColor: FilmTheme.backgroundColor,
          bottom: const TabBar(         
            unselectedLabelColor: Colors.grey,
            labelColor: FilmTheme.acidGreenColor,
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
