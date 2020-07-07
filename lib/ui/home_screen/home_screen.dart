import 'dart:core';

import 'package:albums/themes/colors.dart';
import 'package:albums/ui/album_list/album_list_screen.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:albums/util/extensions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _viewModel.tabs.map((event) => event.tabs),
        builder: (context, snapshot) {
          return Scaffold(
            body: _currentScreen(context, snapshot.data),
            bottomNavigationBar: _bottomNavigationBar(snapshot.data),
          );
        });
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
        _viewModel.onTabSelected(tab);
      },
      items: _navBarItems(tabs),
    );
  }

  Widget _currentScreen(BuildContext context, List<AppTab> tabs) {
    AppTab selectedTab = tabs.getSelectedTab();
    switch (selectedTab?.type) {
      case NavBarItem.BROWSE:
        return AlbumListScreen();
      case NavBarItem.FRIENDS:
      case NavBarItem.NEWS:
      case NavBarItem.PROFILE:
      default:
        return _dummyScreen(context);
    }
  }

  Widget _dummyScreen(BuildContext context) {
    return Text("Coming Soon");
  }

  List<BottomNavigationBarItem> _navBarItems(List<AppTab> tabs) {
    return tabs
        .map((tab) => _tab(tab.title, tab.icon, tab.isSelected))
        .toList();
  }

  BottomNavigationBarItem _tab(String title, AssetImage icon, bool isSelected) {
    return BottomNavigationBarItem(
        title: Text(title,
            style: isSelected
                ? Theme.of(context).textTheme.bodyText1
                : Theme.of(context).textTheme.bodyText2),
        icon: ImageIcon(icon,
            color: isSelected
                ? Theme.of(context).textTheme.bodyText1.color
                : Theme.of(context).textTheme.bodyText2.color));
  }
}
