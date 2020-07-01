import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/ui/photo_list_screen/photo_list_view_model.dart';
import 'package:albums/ui/photo_screen/photo_screen.dart';
import 'package:albums/widgets/error_widget.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhotoListScreen extends StatefulWidget {
  final Album album;

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();

  PhotoListScreen({Key key, @required this.album}) : super(key: key);
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  Future<Result> futurePhotos;
  PhotoListViewModel _viewModel;

  void initState() {
    super.initState();
    _viewModel = PhotoListViewModel(buildPhotosRepo());
    futurePhotos = _viewModel.getPhotos(widget.album.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _photoList(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    Album album = widget.album;
    return AppBar(
      title: Text(album.title),
    );
  }

  Center _photoList(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: futurePhotos,
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              PhotoList photos = (snapshot.data as SuccessState).value;
              return ListView.builder(
                  itemCount: photos.photos.length,
                  itemBuilder: (context, albumId) {
                    return _photoListTile(albumId, photos, context);
                  });
            } else if (snapshot.data is ErrorState) {
              return errorWidget(context, snapshot);
            } else
              return progressIndicator(context);
          }),
    );
  }

  ListTile _photoListTile(
      int index, PhotoList photoList, BuildContext context) {
    Photo photo = photoList.photos[index];
    return ListTile(
        leading: Hero(
          tag: "photoList$index",
          child: Image.network(photo.url),
        ),
        title: Text(photo.title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoScreen(photo: photo),
            ),
          );
        });
  }
}
