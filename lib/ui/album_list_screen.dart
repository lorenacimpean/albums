import 'dart:core';

import 'package:albums/model/albums.dart';
import 'package:albums/model/result.dart';
import 'package:albums/network/remote_data_source.dart';
import 'package:albums/transitions/fade_route.dart';
import 'package:albums/ui/photos_list_screen.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  Future<Result> futureAlbums;

  void initState() {
    super.initState();
    futureAlbums = _fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Center(
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
      ),
    );
  }
}

Future<Result> _fetchAlbums() async {
  RemoteDataSource _apiResponse = RemoteDataSource();
  return _apiResponse.getAlbums();
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
        Navigator.push(context, FadeRoute(page: PhotoListScreen(album: album)));
      });
}