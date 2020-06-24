import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/main_repo.dart';

class AlbumListViewModel {
  final _mainRepo = MainRepo();

  Future<Result> getAlbums() {
    return _mainRepo.getAlbums();
  }
}
