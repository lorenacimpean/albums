import 'dart:async';
import 'dart:core';

import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:albums/ui/extensions.dart';
import 'package:flutter/cupertino.dart';
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
        return _defaultItem.tabsFromNavBarItem();
      }),
      input.onTap.map((tab) {
        return tab.type.tabsFromNavBarItem();
      }),
    ]);

    // Stream<NextScreen> onNextScreen =
    Stream<DeepLinkResult> onNotificationOpened =
        _deeplinkRepo.getDeepLinkResult().map((deepLinkResult) {
      debugPrint(deepLinkResult.action.toString());
      return deepLinkResult;
    });

    output = HomeViewModelOutput(
      onList,
      onNotificationOpened,
    );
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
  final Stream<DeepLinkResult> onNotificationOpened;

  HomeViewModelOutput(
    this.tabs,
    this.onNotificationOpened,
  );
}
