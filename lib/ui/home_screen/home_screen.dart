import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/text_styles.dart';
import 'package:albums/transitions/fade_route.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:albums/ui/views/photos_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  static final albumsRepo = AlbumsRepo();
  final HomeViewModel _viewModel = HomeViewModel(albumsRepo);
  Future<Result> futureAlbums;
  int _currentTabIndex = 0;

  void initState() {
    super.initState();
    futureAlbums = _viewModel.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _albumList(context),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _albumList(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: futureAlbums,
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              Gallery albums = (snapshot.data as SuccessState).value;
              return ListView.separated(
                itemBuilder: (context, index) {
                  return _albumListItem(index, albums, context);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
                itemCount: albums.albumList.length,
                physics: BouncingScrollPhysics(),
              );
            } else if (snapshot.data is ErrorState) {
              String error = (snapshot.data as ErrorState).msg;
              return Text(error);
            } else
              return CircularProgressIndicator();
          }),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/browse_icon.png'),
            color: _changeColorByIndex(0),
          ),
          title: Text('BROWSE',
              style: GoogleFonts.nunito(
                  textStyle: AppTextStyle.navBarStyle,
                  color: _changeColorByIndex(0))),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/friends_icon.png'),
              color: _changeColorByIndex(1)),
          title: Text('FRIENDS',
              style: GoogleFonts.nunito(
                  textStyle: AppTextStyle.navBarStyle,
                  color: _changeColorByIndex(1))),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/news_icon.png'),
            color: _changeColorByIndex(2),
          ),
          title: Text('NEWS',
              style: GoogleFonts.nunito(
                  textStyle: AppTextStyle.navBarStyle,
                  color: _changeColorByIndex(2))),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/profile_icon.png'),
            color: _changeColorByIndex(3),
          ),
          title: Text('PROFILE',
              style: GoogleFonts.nunito(
                  textStyle: AppTextStyle.navBarStyle,
                  color: _changeColorByIndex(3))),
        ),
      ],
      backgroundColor: AppColors.darkBlue,
      onTap: _onTap,
      currentIndex: _currentTabIndex,
      fixedColor: AppColors.brown,
    );
  }

  _onTap(int tabIndex) {
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  Color _changeColorByIndex(int tabIndex) {
    return _currentTabIndex == tabIndex ? AppColors.lightBlue : AppColors.white;
  }

  Widget _albumListItem(int index, Gallery albums, BuildContext context) {
    Album album = albums.albumList[index];
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.only(
        left: _screenWidth * 0.05,
        right: _screenWidth * 0.05,
      ),
      child: ListTile(
          leading: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: ImageIcon(
              AssetImage('assets/images/album_icon.png'),
              color: AppColors.darkBlue,
            ),
          ),
          title: Text('Album name'),
          subtitle: Text('Album with id: ${album.id}'),
          trailing: ImageIcon(AssetImage('assets/images/arrow_icon.png'),
              color: AppColors.darkBlue),
          onTap: () {
            Navigator.push(
                context, FadeRoute(page: PhotoListScreen(album: album)));
          }),
    );
  }
}
