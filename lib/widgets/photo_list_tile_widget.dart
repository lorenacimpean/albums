import 'package:albums/data/model/photos.dart';
import 'package:albums/ui/photo_screen/photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoListTile extends StatelessWidget {
  final int index;
  final PhotoList photoList;

  const PhotoListTile({Key key, @required this.index, @required this.photoList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Photo photo = photoList.photos[index];
    //TODO: add extension photoAtIndex
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
