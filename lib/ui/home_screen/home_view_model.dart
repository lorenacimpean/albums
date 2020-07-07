import 'dart:async';
import 'dart:core';

import 'package:albums/themes/icons.dart';
import 'package:albums/util/extensions.dart';
import 'package:flutter/widgets.dart';

enum NavBarItem { BROWSE, FRIENDS, NEWS, PROFILE }

const NavBarItem _defaultItem = NavBarItem.BROWSE;

class HomeViewModel {
  final StreamController<NavBarTabs> _controller =
      StreamController<NavBarTabs>();

  Stream<NavBarTabs> get tabs => _controller.stream;

  HomeViewModel() {
    _controller.add(NavBarTabs(_getTabList()));
  }

  void dispose() => _controller?.close();

  List<AppTab> _getTabList({NavBarItem selectedTab = _defaultItem}) {
    return NavBarItem.values.map((element) {
      if (element == selectedTab) {
        print('$element');
        return AppTab.fromType(element, isSelected: true);
      }
      return AppTab.fromType(element);
    }).toList();
  }

  void onTabSelected(AppTab tab) {
    _controller.add(NavBarTabs(_getTabList(selectedTab: tab.type)));
  }
}

class NavBarTabs {
  final List<AppTab> tabs;

  NavBarTabs(this.tabs);

  @override
  int get hashCode => tabs.hash;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavBarTabs && tabs.compare(other.tabs);
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

  @override
  int get hashCode =>
      type.hashCode ^ title.hashCode ^ icon.hashCode ^ isSelected.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTab &&
          type == other.type &&
          title == other.title &&
          icon == other.icon &&
          isSelected == other.isSelected;
}
