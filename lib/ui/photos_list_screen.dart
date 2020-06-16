import 'package:albums/model/photos.dart';
import 'package:albums/model/result.dart';
import 'package:albums/network/remote_data_source.dart';
import 'package:albums/ui/photo_screen.dart';
import 'package:flutter/material.dart';

class PhotoListScreen extends StatefulWidget {
  final String title;
  final int index;

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();

  PhotoListScreen({Key key, @required this.title, @required this.index})
      : super(key: key);
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getPhotos(widget.index),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                PhotoList photos = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: photos.photos.length,
                    itemBuilder: (context, index) {
                      return photoListTile(index, photos, context);
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

ListTile photoListTile(
    int photoIndex, PhotoList photoList, BuildContext context) {
  var photo = photoList.photos[photoIndex];
  return ListTile(
      leading: Image.network(photo.thumbnailUrl),
      title: Text(photo.title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoScreen(url: photo.url),
          ),
        );
      });
}
