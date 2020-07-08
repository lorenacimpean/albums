import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/widgets/album_details_icon_widgets.dart';

class PhotoListViewModel {
  final PhotosRepo photosRepo;
  StreamController<ActionType> controller = StreamController();

  PhotoListViewModel(this.photosRepo);

  Future<Result> getPhotos(int id) {
    return photosRepo.getPhotos(id);
  }


//  onActionTap(Album album, ActionType actionType)
//  showToast(): Stream<String>
//  “Action is add to fav for album {album_title}”
//getPhotosCount(Album album): Future<int> (use repo.getPhotos() and compute the count)


}

enum ActionType { SaveToFavorites, AddComment }