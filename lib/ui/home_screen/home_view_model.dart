import 'dart:async';

import 'package:flutter/widgets.dart';

enum NavBarItem { BROWSE, FRIENDS, NEWS, PROFILE }

class HomeViewModel {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final StreamController<NavBarItem> _navigationController =
      StreamController<NavBarItem>.broadcast();
  NavBarItem defaultItem = NavBarItem.BROWSE;


  Stream<NavBarItem> get itemStream => _navigationController.stream;

  void dispose() => _navigationController?.close();

  onTabSelected(int tabIndex) {
    switch (tabIndex) {
      case 0:
        navigatorKey.currentState.pushNamed('AlbumList');
        break;
      case 1:
        navigatorKey.currentState.pushNamed("Friends");
        break;
      case 2:
        navigatorKey.currentState.pushNamed("News");
        break;
      case 2:
        navigatorKey.currentState.pushNamed("Profile");
        break;
    }
  }
}
