import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/transitions/fade_route.dart';
import 'package:albums/ui/views/photos_list_screen.dart';
import 'package:flutter/material.dart';

import 'album_list_view_model.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  AlbumListViewModel _viewModel;
  Future<Result> futureAlbums;

  void initState() {
    super.initState();
    _viewModel = AlbumListViewModel(buildAlbumsRepo());
    futureAlbums = _viewModel.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _albumList(context),
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
