import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/photos_remote_data_source.dart';

AlbumsRemoteDataSource buildAlbumsRemoteDataSource() {
  return AlbumsRemoteDataSource(AppHttpClient());
}

PhotosRemoteDataSource buildPhotosRemoteDataSource() {
  return PhotosRemoteDataSource(AppHttpClient());
}
