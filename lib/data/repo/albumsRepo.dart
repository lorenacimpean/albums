import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/model/result.dart';

class AlbumsRepo {
  final AlbumsRemoteDataSource _albumsRemoteDataSource;

  AlbumsRepo(this._albumsRemoteDataSource);

  Future<Result> getAlbums() {
    return _albumsRemoteDataSource.getAlbums();
  }
}
