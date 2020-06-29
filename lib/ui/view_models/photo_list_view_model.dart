import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/main_repo.dart';

class PhotoListViewModel {
  final _mainRepo = MainRepo();

  Future<Result> getPhotos(int id) {
    return _mainRepo.getPhotos(id);
  }
}
