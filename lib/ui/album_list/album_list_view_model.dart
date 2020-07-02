import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';

class AlbumListViewModel {
  final AlbumsRepo _albumsRepo;

  AlbumListViewModel(this._albumsRepo);

  Future<Result> getAlbums() {
    Future<Result> futureAlbumList = _albumsRepo.getAlbums();
    return futureAlbumList;
  }

  Album getCurrentAlbum(AlbumList albums, int index) {
    Album album = albums.albumList[index];
    return album;
  }
}
