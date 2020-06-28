import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';

class PhotoListViewModel extends PhotosRepo {
  final PhotosRepo photosRepo;

  PhotoListViewModel(this.photosRepo) : super(photosRepo);

  Future<Result> getPhotos(int id) {
    return photosRepo.getPhotos(id);
  }
}
