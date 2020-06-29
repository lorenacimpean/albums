import 'package:albums/data/api/remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class MainRepo {
  final _remoteDataSource = RemoteDataSource();

  Future<Result> getAlbums() {
    return _remoteDataSource.getAlbums();
  }

  Future<Result> getPhotos(int id) {
    return _remoteDataSource.getPhotos(id);
  }
}
