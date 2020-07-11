import 'package:albums/data/api/photos_remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class PhotosRepo {
  final PhotosRemoteDataSource _remoteDataSource;

  PhotosRepo(this._remoteDataSource);

  Future<Result> getPhotoList(int id) {
    return _remoteDataSource.getPhotos(id);
  }
}
