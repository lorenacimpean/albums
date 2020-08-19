import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/rxdart.dart';

//Example url:
// app://albums.com/contactinfo?firstname=john&lastname=snow);

class DeepLinkRepo {
  final OneSignal _oneSignal;
  final Subject<Uri> _deepLinkUri;

  DeepLinkRepo(this._deepLinkUri, this._oneSignal);

  Stream<DeepLinkResult> getDeepLinkResult() {
    _oneSignal.setNotificationOpenedHandler((openedResult) {
      _deepLinkUri.add(
        Uri.parse(openedResult.notification.payload.launchUrl ?? ""),
      );
    });
    return  _deepLinkUri.map((uri) {
      debugPrint(uri.toString());
      return DeepLinkResult.fromUri(uri);
    });
  }
}

class DeepLinkResult {
  final DeepLinkAction action;
  final Map<String, String> value;

  DeepLinkResult(
    this.action, {
    this.value,
  });

  factory DeepLinkResult.fromUri(Uri uri) {
    DeepLinkAction action;
    switch (uri.pathSegments.last) {
      //tabs
      case 'home':
        action = DeepLinkAction.openHome;
        break;
      case 'friends':
        action = DeepLinkAction.openFriends;
        break;
      case 'news':
        action = DeepLinkAction.openNews;
        break;
      case 'profile':
        action = DeepLinkAction.openProfile;
        break;
      //screens
      case 'contactinfo':
        action = DeepLinkAction.openContactInfo;
        break;
      case 'notifications':
        action = DeepLinkAction.openNotifications;
        break;
      default:
        action = DeepLinkAction.openHome;
        break;
    }
    Map<String, String> screenData = uri.queryParameters;
    return DeepLinkResult(
      action,
      value: screenData,
    );
  }

  NavBarItem getNavBarItemFromDeepLinkResult() {
    DeepLinkAction action = this.action;
    switch (action) {
      case DeepLinkAction.openHome:
        return NavBarItem.BROWSE;
        break;
      case DeepLinkAction.openFriends:
        return NavBarItem.FRIENDS;
        break;
      case DeepLinkAction.openNews:
        return NavBarItem.NEWS;
        break;
      case DeepLinkAction.openProfile:
      case DeepLinkAction.openContactInfo:
      case DeepLinkAction.openNotifications:
        return NavBarItem.PROFILE;
        break;
      default:
        return null;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeepLinkResult &&
          runtimeType == other.runtimeType &&
          action == other.action &&
          value == other.value;

  @override
  int get hashCode => action.hashCode ^ value.hashCode;
}

enum DeepLinkAction {
  //tabs
  openHome,
  openFriends,
  openNews,
  openProfile,
  //screens
  openContactInfo,
  openNotifications,
}
