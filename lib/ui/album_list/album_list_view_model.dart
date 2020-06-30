import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';

class AlbumListViewModel {
  final AlbumsRepo _albumsRepo;

  AlbumListViewModel(this._albumsRepo);

  Future<Result> getAlbums() {
    return _albumsRepo.getAlbums();
  }
}
