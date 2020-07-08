import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhotosInAlbumWidget extends StatelessWidget {
  final int photosCount;

  const PhotosInAlbumWidget({
    Key key,
    @required this.photosCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: AppPaddings.albumDetailsWidgetIconFlex,
      child: Column(
        children: <Widget>[
          Text(
            '$photosCount',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(AppStrings.photos, style: Theme.of(context).textTheme.subtitle2)
        ],
      ),
    );
  }
}
