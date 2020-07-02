import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/photos_remote_data_source.dart';
import 'package:albums/data/repo/photos_repo.dart';



PhotosRepo buildPhotosRepo() {
  return PhotosRepo(buildPhotosRemoteDataSource());
}

PhotosRemoteDataSource buildPhotosRemoteDataSource() {
  return PhotosRemoteDataSource(AppHttpClient());
}
