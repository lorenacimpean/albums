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

  AlbumList sortAlbums(AlbumList albums) {
    return albums.sortList();
  }

  Album albumAtIndex(AlbumList albums, int index) {
    return albums.albumAtIndex(index);
  }

  Future<bool> goToNext() {
    return Future.value(true);
  }
}
