import 'dart:core';

import 'package:albums/themes/colors.dart';
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
        stream: _viewModel.tabs,
        initialData: List<AppTab>(),
        builder: (context, snapshot) {
          return _currentScreen(context, snapshot.data);
        },
      ),
      bottomNavigationBar: StreamBuilder<List<AppTab>>(
        stream: _viewModel.tabs,
        builder: (context, snapshot) {
          print('snapshot: ${snapshot.data}');
          //Apptabs widget - clasa separ{ata
          if (snapshot.data.length < 2) {
            return Container();
          }
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.darkBlue,
            //extensie lista de app tab care sa returneze selected index
            currentIndex: 0,
            onTap: (index) {},
            items: _navBarItems(snapshot.data),
          );
        },
      ),
    );
  }

//extensie pentru lista de apptab care sa returneze selected tab
  Widget _currentScreen(BuildContext context, List<AppTab> tabs) {
    //change with firstwhere
    AppTab selectedTab;
    tabs.forEach((element) {
      if (element.isSelected) {
        selectedTab = element;
      }
    });
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
    return Container(child: Center(child: Text("Coming Soon")));
  }

  List<BottomNavigationBarItem> _navBarItems(List<AppTab> tabs) {
    return tabs.map((e) => _tab(e)).toList();
  }

  BottomNavigationBarItem _tab(AppTab tab) {
    return BottomNavigationBarItem(
        title: Text(tab.title), icon: ImageIcon(tab.icon));
  }
//Widget
// TAB widget
//Tabs widget
}
