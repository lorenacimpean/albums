import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/model/albums.dart';

class AlbumsRepo {
  final AlbumsRemoteDataSource _albumsRemoteDataSource;

  AlbumsRepo(this._albumsRemoteDataSource);

  Stream<AlbumList> getAlbums() {
    return _albumsRemoteDataSource.getAlbums();
  }
}
