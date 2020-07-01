import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/photos_remote_data_source.dart';
import 'package:albums/data/repo/photos_repo.dart';

import 'albumsRepo.dart';

AlbumsRepo buildAlbumsRepo() {
  return AlbumsRepo(buildAlbumsRemoteDataSource());
}

PhotosRepo buildPhotosRepo() {
  return PhotosRepo(buildPhotosRemoteDataSource());
}

PhotosRemoteDataSource buildPhotosRemoteDataSource() {
  return PhotosRemoteDataSource(AppHttpClient());
}

AlbumsRemoteDataSource buildAlbumsRemoteDataSource() {
  return AlbumsRemoteDataSource(AppHttpClient());
}
