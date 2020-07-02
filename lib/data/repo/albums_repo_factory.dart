import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';

import 'albumsRepo.dart';

AlbumsRepo buildAlbumsRepo() {
  return AlbumsRepo(buildAlbumsRemoteDataSource());
}

AlbumsRemoteDataSource buildAlbumsRemoteDataSource() {
  return AlbumsRemoteDataSource(AppHttpClient());
}
