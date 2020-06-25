import 'package:albums/data/api/remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class PhotosRepo {
  final _remoteDataSource = RemoteDataSource();

  Future<Result> getPhotos(int id) {
    return _remoteDataSource.getPhotos(id);
  }
}
