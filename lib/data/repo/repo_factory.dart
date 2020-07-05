import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/data/repo/remote_data_source_factory.dart';

import 'albumsRepo.dart';

AlbumsRepo buildAlbumsRepo() {
  return AlbumsRepo(buildAlbumsRemoteDataSource());
}

PhotosRepo buildPhotosRepo() {
  return PhotosRepo(buildPhotosRemoteDataSource());
}
