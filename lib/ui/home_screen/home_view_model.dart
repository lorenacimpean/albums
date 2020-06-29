import 'dart:async';
import 'dart:core';

import 'package:albums/themes/icons.dart';
import 'package:flutter/widgets.dart';

enum NavBarItem { BROWSE, FRIENDS, NEWS, PROFILE }

const NavBarItem _defaultItem = NavBarItem.BROWSE;

class HomeViewModel {
  final StreamController<List<AppTab>> _controller =
      StreamController<List<AppTab>>.broadcast();

  Stream<List<AppTab>> get tabs => _controller.stream;

  HomeViewModel() {
    _controller.add(getTabList());
  }

  void dispose() => _controller?.close();

  List<AppTab> getTabList({NavBarItem selectedTab = _defaultItem}) {
    return NavBarItem.values.map((element) {
      if (element == selectedTab) {
        print('$element');
        return AppTab.fromType(element, isSelected: true);
      }
      return AppTab.fromType(element);
    }).toList();
  }

  void onTabSelected(AppTab tab) {
    _controller.add(getTabList(selectedTab: tab.type));
  }
}

class AppTab {
  final NavBarItem type;
  final String title;
  final AssetImage icon;
  bool isSelected;

  AppTab(this.type, this.title, this.icon, this.isSelected);

  factory AppTab.fromType(NavBarItem type, {bool isSelected = false}) {
    switch (type) {
      case NavBarItem.BROWSE:
        return AppTab(
            NavBarItem.BROWSE, "BROWSE", AppIcons.browseIcon, isSelected);
      case NavBarItem.FRIENDS:
        return AppTab(
            NavBarItem.FRIENDS, "FRIENDS", AppIcons.friendsIcon, isSelected);
      case NavBarItem.NEWS:
        return AppTab(NavBarItem.NEWS, "NEWS", AppIcons.newsIcon, isSelected);
      case NavBarItem.PROFILE:
        return AppTab(
            NavBarItem.PROFILE, "PROFILE", AppIcons.profileIcon, isSelected);
      default:
        return null;
    }
  }
}

//extensie pentru lista de apptab care sa returneze selected tab
extension selectedIndex on List<AppTab> {
  int getSelectedIndex() {
    AppTab selectedTab = this.getSelectedTab();
    int index = indexOf(selectedTab);
    return index;
  }
}

extension selectedTab on List<AppTab> {
  AppTab getSelectedTab() {
    AppTab selectedTab = this?.firstWhere((tab) => tab.isSelected);
    return selectedTab;
  }
}
