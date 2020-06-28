import 'package:albums/data/api/remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class PhotosRepo extends RemoteDataSource {
  RemoteDataSource _remoteDataSource;

  PhotosRepo(this._remoteDataSource) : super(_remoteDataSource);

  Future<Result> getPhotos(int id) {
    return _remoteDataSource.getPhotos(id);
  }
}
