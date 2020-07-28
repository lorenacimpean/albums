import 'package:albums/ui/album_details/album_details_screen.dart';
import 'package:albums/ui/contact_info/contact_info_screen.dart';
import 'package:albums/ui/home_screen/home_screen.dart';
import 'package:albums/ui/notifications/notifications_screen.dart';
import 'package:albums/ui/photo_gallery_screen/photo_gallery_screen.dart';
import 'package:flutter/material.dart';

enum ScreenType {
  HomeScreen,
  AlbumDetails,
  Photos,
  ContactInfo,
  NotificationsScreen
}

class NextScreen {
  final ScreenType type;
  final dynamic data;

  NextScreen(this.type, this.data);
}

void openNextScreen(BuildContext context, NextScreen nextScreen) {
  switch (nextScreen.type) {
    case ScreenType.HomeScreen:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      break;
    case ScreenType.AlbumDetails:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AlbumDetailsScreen(album: nextScreen.data),
        ),
      );
      break;
    case ScreenType.Photos:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoGalleryScreen(
            galleryDetails: nextScreen.data,
          ),
        ),
      );
      break;
    case ScreenType.ContactInfo:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ContactInfoScreen(),
        ),
      );
      break;
    case ScreenType.NotificationsScreen:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotificationsScreen(),
        ),
      );
      break;
  }
}
