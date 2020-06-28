import 'dart:core';

import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/ui/album_list/album_list_screen.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
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
    return Scaffold(
      body: StreamBuilder(
        stream: _viewModel.stream,
        initialData: _viewModel.defaultItem,
        builder: (context, tabs) {
          return _changeScreen(context, tabs);
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _viewModel.stream,
        initialData: _viewModel.defaultItem,
        builder: (context, tabs) {
          return Theme(
            data: Theme.of(context),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.darkBlue,
              currentIndex: tabs.data.index,
              onTap: _viewModel.onTabSelected,
              items: _navBarItems(),
            ),
          );
        },
      ),
    );
  }

  Widget _changeScreen(context, tabs) {
    switch (tabs.data) {
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
    return Container(child: Center(child: Text("Coming Soon")));
  }

  List<BottomNavigationBarItem> _navBarItems() {
    List<BottomNavigationBarItem> tabList = [];
    int selectedTab = _viewModel.selectedTabIndex;
    List<String> titleList = _tabTitles();
    _tabTitles().asMap().forEach((index, item) {
      tabList.add(
          _tab(titleList[index], _tabBarIcons[index], index == selectedTab));
    });
    return tabList;
  }

  BottomNavigationBarItem _tab(String title, AssetImage icon, bool isSelected) {
    return BottomNavigationBarItem(
        title: Text(title),
//            style: isSelected
//                ? AppTextStyle.navBarSelected
//                : AppTextStyle.navBarDefault),
        icon: ImageIcon(icon));
          //  , color: isSelected ? AppColors.lightBlue : AppColors.white));
  }

  final List<AssetImage> _tabBarIcons = const [
    AppIcons.browseIcon,
    AppIcons.friendsIcon,
    AppIcons.newsIcon,
    AppIcons.profileIcon
  ];

  //create list of tab titles from enum
  List<String> _tabTitles() {
    List<String> titles = [];
    //remove 'NavBarItem.'
    NavBarItem.values.forEach((element) {
      titles.add('$element'.substring(element.toString().indexOf('.') + 1));
    });
    return titles;
  }
}
