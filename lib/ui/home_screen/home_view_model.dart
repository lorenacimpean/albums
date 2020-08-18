import 'dart:async';
import 'dart:core';

import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:albums/ui/next_screen.dart';
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
        return _getTabList(_defaultItem);
      }),
      input.onTap.map((tab) {
        return _getTabList(tab.type);
      }),
    ]);

    Stream<NextScreen> onNextScreen = _deeplinkRepo.getUri().flatMap((uri) {
      return _deeplinkRepo.getDeepLinkResult().map((deeplinkResult) {
        return NextScreen(_screenTypeFromAction(deeplinkResult.action), null);
      });
    });

    output = HomeViewModelOutput(
      onList,
      onNextScreen,
    );
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

  ScreenType _screenTypeFromAction(DeepLinkAction action) {
    switch (action) {
      case DeepLinkAction.openAlbumDetails:
        return ScreenType.AlbumDetails;
        break;
      case DeepLinkAction.openPhotos:
        return ScreenType.Photos;
        break;
      case DeepLinkAction.openContactInfo:
        return ScreenType.ContactInfo;
        break;
      case DeepLinkAction.openNotifications:
        return ScreenType.NotificationsScreen;
        break;
      case DeepLinkAction.openHome:
      default:
        return ScreenType.HomeScreen;
        break;
    }
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
  final Stream<NextScreen> nextScreen;

  HomeViewModelOutput(
    this.tabs,
    this.nextScreen,
  );
}
