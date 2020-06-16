import 'package:albums/model/albums.dart';
import 'package:albums/model/result.dart';
import 'package:albums/network/remote_data_source.dart';
import 'package:albums/ui/photos_list_screen.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getAlbums(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                Gallery albums = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: albums.albumList.length,
                    itemBuilder: (context, index) {
                      return albumListTile(index, albums, context);
                    });
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

ListTile albumListTile(
    int albumIndex, Gallery albumList, BuildContext context) {
  var albumTitle = albumList.albumList[albumIndex].title;
  return ListTile(
      leading: Icon(Icons.photo_album),
      title: Text(albumTitle),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PhotoListScreen(title: albumTitle, index: albumIndex),
          ),
        );
      });
}
