import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';

class AlbumListViewModel {
  final AlbumsRepo albumsRepo;

  AlbumListViewModel(this.albumsRepo);

  Future<Result> getAlbums() {
    return albumsRepo.getAlbums();
  }
}
