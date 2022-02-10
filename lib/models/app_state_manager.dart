import 'dart:async';
import 'package:flutter/material.dart';

class FindAnyMoviesTab {
  static const int news = 0;
  static const int films = 1;
  //TODO add series
}

class AppStateManager extends ChangeNotifier {
  bool _loggedIn = false;
  bool _pressedSignup = false;
  bool _pressedLogin = false;
  bool _initialized = false;
  int _selectedTab = FindAnyMoviesTab.news;
  bool _didSelectCard = false;

  bool get didPressLogin => _pressedLogin;
  bool get isLoggedIn => _loggedIn;
  bool get didPressSignup => _pressedSignup;
  bool get isInitialized => _initialized;
  int get getSelectedTab => _selectedTab;
  bool get didSelectCard => _didSelectCard;

  void initializeApp() {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void login(String email, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  void tapOnSignup(bool pressed) {
    _pressedSignup = pressed;
    notifyListeners();
  }

  void tapOnLogin(bool pressed) {
    _pressedLogin = pressed;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void tapOnCard(bool selected) {
    _didSelectCard = selected;
    notifyListeners();
  }
}
