import 'package:albums/data/api/remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class AlbumsRepo {
  final _remoteDataSource = RemoteDataSource();

  Future<Result> getAlbums() {
    return _remoteDataSource.getAlbums();
  }
}