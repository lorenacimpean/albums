import 'package:albums/data/model/photos.dart';
import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

import 'horizontal_separator.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  final GestureTapCallback onTap;

  const PhotoListItem({Key key,  @required this.photo, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: add extension photoAtIndex
    return Column(
      children: <Widget>[
        HorizontalSeparator(),
        Padding(
          padding: EdgeInsets.all(AppPaddings.defaultPadding),
          child: ListTile(
              leading: Hero(
                tag: "photoList${photo.id}",
                child: Image.network(photo.url),
              ),
              title: Text(photo.title),
              onTap: () {
                if (onTap != null) {
                  onTap();
                }
              },
          ),
        ),
      ],
    );
  }
}
