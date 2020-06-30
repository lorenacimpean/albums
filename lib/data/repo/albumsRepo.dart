import 'package:albums/data/api/remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class AlbumsRepo  {

 final  RemoteDataSource _remoteDataSource;
  AlbumsRepo(this._remoteDataSource);

  Future<Result> getAlbums() {
    return _remoteDataSource.getAlbums();
  }
}
