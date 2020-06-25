import 'dart:core';

import 'package:albums/themes/colors.dart';
import 'package:albums/themes/text_styles.dart';
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
      body: Navigator(
          key: _viewModel.navigatorKey, onGenerateRoute: generateRoute),
      bottomNavigationBar: StreamBuilder(
        stream: _viewModel.itemStream,
        initialData: _viewModel.defaultItem,
        builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
          return Theme(
            data: Theme.of(context).copyWith(
                //active color
                primaryColor: AppColors.white,
                //inactive color, size
                textTheme: Theme.of(context).textTheme.copyWith(
                      caption: AppTextStyle.navBarDefault,
                    )),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.darkBlue,
              currentIndex: snapshot.data.index,
              selectedLabelStyle: AppTextStyle.navBarSelected,
              unselectedLabelStyle: AppTextStyle.navBarDefault,
              onTap: _viewModel.onTabSelected,
              items: _items(),
            ),
          );
        },
      ),
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case 'AlbumList':
        return MaterialPageRoute(builder: (context) => AlbumListScreen());
      default:
        return MaterialPageRoute(
            builder: (context) =>
                Container(child: Center(child: Text("Coming Soon"))));
    }
  }

  List<BottomNavigationBarItem> _items() {
    return [
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/browse_icon.png'),
        ),
        title: Text('BROWSE'),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/friends_icon.png'),
        ),
        title: Text('FRIENDS'),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/news_icon.png'),
        ),
        title: Text('NEWS'),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/profile_icon.png'),
        ),
        title: Text('PROFILE'),
      ),
    ];
  }
}
