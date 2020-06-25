import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';

class HomeViewModel {
  final AlbumsRepo albumsRepo;

  HomeViewModel(this.albumsRepo);

  Future<Result> getAlbums() {
    return albumsRepo.getAlbums();
  }
}
