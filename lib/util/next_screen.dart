import 'package:albums/ui/album_details/album_details_screen.dart';
import 'package:albums/ui/photo_gallery_screen/photo_gallery_screen.dart';
import 'package:flutter/material.dart';

enum ScreenType { AlbumDetails, Photos }

class NextScreen {
  final ScreenType type;
  final dynamic data;

  NextScreen(this.type, this.data);
}

route(BuildContext context, NextScreen nextScreen) {
  switch (nextScreen.type) {
    case ScreenType.AlbumDetails:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AlbumDetailsScreen(album: nextScreen.data)));
      break;
    case ScreenType.Photos:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhotoScreen(photos: nextScreen.data)));
      break;
  }
}
