import 'dart:async';
import 'dart:core';

import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'app_tab_model.dart';

enum NavBarItem { BROWSE, FRIENDS, NEWS, PROFILE }

const NavBarItem _defaultItem = NavBarItem.BROWSE;

class HomeViewModel {
  final DeepLinkRepo _deeplinkRepo;
  final HomeViewModelInput input;
  HomeViewModelOutput output;

  HomeViewModel(
    this.input,
    this._deeplinkRepo,
  ) {
    Stream<List<AppTab>> onList = MergeStream([
      input.onStart.map((_) {
        return _getTabsFromNavBarItem(selected: _defaultItem);
      }),
      input.onTap.map((tab) {
        return _getTabsFromNavBarItem(selected: tab.type);
      }),
      _deeplinkRepo.getDeepLinkResult()?.map((deepLinkResult) {
        return _getTabsFromNavBarItem(deepLinkResult: deepLinkResult);
      }),
    ]);

    output = HomeViewModelOutput(onList);
  }

  List<AppTab> _getTabsFromNavBarItem(
      {NavBarItem selected, DeepLinkResult deepLinkResult}) {
    if (deepLinkResult != null) {
      selected = deepLinkResult.getNavBarItemFromDeepLinkResult();
    }
    return NavBarItem.values.map((element) {
      if (element == selected) {
        return AppTab.fromType(
          element,
          isSelected: true,
          deepLinkResult: deepLinkResult,
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
    this.onStart,
    this.onTap,
  );
}

class HomeViewModelOutput {
  final Stream<List<AppTab>> tabs;

  HomeViewModelOutput(
    this.tabs,
  );
}
