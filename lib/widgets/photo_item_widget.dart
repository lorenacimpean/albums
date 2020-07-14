import 'package:albums/data/model/photos.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
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

        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical:AppPaddings.midPadding),
            leading: Hero(
              tag: "photoList${photo.id}",
              child: Image.network(photo.url),
            ),
            title: Text(photo.title),
            subtitle: Text('${AppStrings.photoWithId} ${photo.id}'),
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
        ),
        HorizontalSeparator(),
      ],
    );
  }
}
