import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';

class AlbumListViewModel extends AlbumsRepo {
   AlbumsRepo _albumsRepo;
   AlbumListViewModel(this._albumsRepo) : super(_albumsRepo);

  Future<Result> getAlbums() {
    return _albumsRepo.getAlbums();
  }
}
