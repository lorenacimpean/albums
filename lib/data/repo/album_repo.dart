import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';

class AlbumsRepo {
  final AlbumsRemoteDataSource _albumsRemoteDataSource;

  AlbumsRepo(this._albumsRemoteDataSource);

  Stream<Result<AlbumList>> getAlbums() {
    return _albumsRemoteDataSource.getAlbums();
  }
}
