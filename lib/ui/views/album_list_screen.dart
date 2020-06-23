import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/transitions/fade_route.dart';
import 'package:albums/ui/photos_list_screen.dart';
import 'package:albums/ui/view_models/album_list_view_model.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  Future<Result> futureAlbums;
  final _viewModel = AlbumListViewModel();

  void initState() {
    super.initState();

    futureAlbums = _viewModel.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _albumList(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text('Albums'),
      key: Key('title'),
    );
  }

  Center _albumList(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: futureAlbums,
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              Gallery albums = (snapshot.data as SuccessState).value;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return _albumListItem(index, albums, context);
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

  ListTile _albumListItem(int index, Gallery albums, BuildContext context) {
    Album album = albums.albumList[index];
    return ListTile(
        leading: ImageIcon(
          AssetImage('assets/images/photoAlbum.png'),
          color: Colors.pink,
          size: 50.00,
        ),
        title: Text(album.title),
        onTap: () {
          Navigator.push(
              context, FadeRoute(page: PhotoListScreen(album: album)));
        });
  }
}
