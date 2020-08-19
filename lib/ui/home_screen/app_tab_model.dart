import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:albums/themes/icons.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';

class AppTab {
  final NavBarItem type;
  final String title;
  final AssetImage icon;
  DeepLinkResult deepLinkResult;
  bool isSelected;

  AppTab(this.type, this.title, this.icon, this.isSelected,
      {this.deepLinkResult});

  factory AppTab.fromType(NavBarItem type,
      {bool isSelected = false, DeepLinkResult deepLinkResult}) {
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
            NavBarItem.PROFILE, "PROFILE", AppIcons.profileIcon, isSelected,
            deepLinkResult: deepLinkResult);
      default:
        return null;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTab &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          title == other.title &&
          icon == other.icon &&
          deepLinkResult == other.deepLinkResult &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      type.hashCode ^
      title.hashCode ^
      icon.hashCode ^
      deepLinkResult.hashCode ^
      isSelected.hashCode;
}
