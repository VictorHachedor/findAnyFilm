import 'package:find_any_movie/auth_reg/auth_reg_home.dart';
import 'package:find_any_movie/models/app_state_manager.dart';
import 'package:find_any_movie/models/models.dart';
import 'package:find_any_movie/screens/film_details.dart';
import 'package:find_any_movie/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  //TODO add final profile manager

  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    //TODO add profile manager
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    //TODO remove profile listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
        FilmList.page(),
       // MainScreen.page(appStateManager.getSelectedTab),

        if (appStateManager.didSelectCard) FilmDetails.page(),

        //  if (appStateManager.isLoggedIn) MainScreen.page(),
        // TODO: Add Profile(movie) Screen
        // TODO: Add film card screen
        // TODO: Add collections screen
        // TODO: Add Film Certificates screen
        // TODO: Add Terms & Conditions screen
        // TODO: Add Privacy Policy screen
        // TODO: Add Cookie Policy screen
        // TODO: Add FAQ screen
        // and maybe more
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FindAnyMoviesPages.authRegHomePath) {
      appStateManager.tapOnLogin(false); // wtf is this?
    }
    // TODO: Handle state when user closes profile screen

    if (route.settings.name == FindAnyMoviesPages.filmDetailsPath){
      appStateManager.tapOnCard(false);
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    return null;
  }
}
