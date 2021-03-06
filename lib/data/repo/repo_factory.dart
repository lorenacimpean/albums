import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:albums/data/repo/location_repo.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/data/repo/remote_data_source_factory.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'album_repo.dart';

AlbumsRepo buildAlbumsRepo() {
  return AlbumsRepo(
    buildAlbumsRemoteDataSource(),
  );
}

PhotosRepo buildPhotosRepo() {
  return PhotosRepo(
    buildPhotosRemoteDataSource(),
  );
}

UserProfileRepo buildUserProfileRepo() {
  return UserProfileRepo();
}

LocationRepo buildLocationRepo() {
  return LocationRepo(
    Location(),
    Geocoder.local,
  );
}

DeepLinkRepo buildDeepLinkRepo() {
  return DeepLinkRepo(
    PublishSubject(),
    OneSignal.shared,
  );
}
