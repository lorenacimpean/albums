import 'dart:async';
import 'dart:core';

import 'package:rxdart/rxdart.dart';

import 'app_tab_model.dart';

enum NavBarItem { BROWSE, FRIENDS, NEWS, PROFILE }

const NavBarItem _defaultItem = NavBarItem.BROWSE;

class HomeViewModel {
  final HomeViewModelInput input;
  HomeViewModelOutput output;

  HomeViewModel(this.input) {
    Stream<List<AppTab>> onList = MergeStream([
      input.onStart.map((_) {
        return _getTabList(_defaultItem);
      }),
      input.onTap.map((tab) {
        return _getTabList(tab.type);
      }),
    ]);
    output = HomeViewModelOutput(onList);
  }

  List<AppTab> _getTabList(NavBarItem selectedTab) {
    return NavBarItem.values.map((element) {
      if (element == selectedTab) {
        print('$element');
        return AppTab.fromType(
          element,
          isSelected: true,
        );
      }
      return AppTab.fromType(element);
    }).toList();
  }
}

class HomeViewModelInput {
  final Subject<bool> onStart;
  final Subject<AppTab> onTap;

  HomeViewModelInput(
    this.onTap,
    this.onStart,
  );
}

class HomeViewModelOutput {
  final Stream<List<AppTab>> tabs;

  HomeViewModelOutput(this.tabs);
}
