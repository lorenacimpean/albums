import 'dart:core';

import 'package:albums/themes/colors.dart';
import 'package:albums/ui/album_list/album_list_screen.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/ui/friends/friends_screen.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:albums/ui/news/news_screen.dart';
import 'package:albums/ui/profile/your_profile_screen.dart';
import 'package:albums/widgets/base_state.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'app_tab_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  HomeViewModel _viewModel;
  List<AppTab> _tabs;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      HomeViewModelInput(
        PublishSubject(),
        PublishSubject(),
      ),
    );

    disposeLater(
      _viewModel.output.tabs.listen((tabs) {
        setState(() {
          _tabs = tabs;
        });
      }),
    );
    _viewModel.input.onStart.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentScreen(_tabs),
      bottomNavigationBar: _bottomNavigationBar(_tabs),
    );
  }

  Widget _bottomNavigationBar(List<AppTab> tabs) {
    if ((tabs?.length ?? 0) < 2) {
      return Container();
    }
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkBlue,
      currentIndex: tabs.getSelectedIndex(),
      onTap: (index) {
        AppTab tab = tabs[index];
        _viewModel.input.onTap.add(tab);
      },
      items: _navBarItems(tabs),
    );
  }

  Widget _currentScreen(List<AppTab> tabs) {
    AppTab selectedTab = tabs?.getSelectedTab();
    switch (selectedTab?.type) {
      case NavBarItem.BROWSE:
        return AlbumListScreen();
      case NavBarItem.FRIENDS:
        return FriendsScreen();
      case NavBarItem.NEWS:
        return NewsScreen();
      case NavBarItem.PROFILE:
        return YourProfileScreen();
    }
  }

  List<BottomNavigationBarItem> _navBarItems(List<AppTab> tabs) {
    return tabs
        .map((tab) => _tab(tab.title, tab.icon, tab.isSelected))
        .toList();
  }

  BottomNavigationBarItem _tab(
    String title,
    AssetImage icon,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      title: Text(title,
          style: isSelected
              ? Theme.of(context).textTheme.bodyText1
              : Theme.of(context).textTheme.bodyText2),
      icon: ImageIcon(icon,
          color: isSelected
              ? Theme.of(context).textTheme.bodyText1.color
              : Theme.of(context).textTheme.bodyText2.color),
    );
  }
}
