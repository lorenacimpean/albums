import 'package:albums/model/albums.dart';
import 'package:albums/model/photos.dart';
import 'package:albums/model/result.dart';
import 'package:albums/network/remote_data_source.dart';
import 'package:albums/ui/photo_screen.dart';
import 'package:flutter/material.dart';

class PhotoListScreen extends StatefulWidget {
  final Album album;

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();

  PhotoListScreen({Key key, @required this.album}) : super(key: key);
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Album album = widget.album;
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getPhotos(album.id),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                PhotoList photos = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: photos.photos.length,
                    itemBuilder: (context, albumId) {
                      return _photoListTile(albumId, photos, context);
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

ListTile _photoListTile(
    int albumId, PhotoList photoList, BuildContext context) {
  Photo photo = photoList.photos[albumId];
  return ListTile(
      leading: Hero(
        tag: "photoList$albumId",
        child: Image.network(photo.url),
      ),
      title: Text(photo.title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoScreen(url: photo.url, index: albumId),
          ),
        );
      });
}
