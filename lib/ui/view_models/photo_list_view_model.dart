import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';

class PhotoListViewModel {
  final PhotosRepo photosRepo;

  PhotoListViewModel(this.photosRepo);

  Future<Result> getPhotos(int id) {
    return photosRepo.getPhotos(id);
  }
}
