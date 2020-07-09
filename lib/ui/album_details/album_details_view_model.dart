import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/themes/strings.dart';

class AlbumDetailsViewModel {
  final PhotosRepo photosRepo;
  StreamController<TapAction> _controller = StreamController<TapAction>();

  Stream<TapAction> get action => _controller.stream;

  AlbumDetailsViewModel(this.photosRepo);

  void dispose() {
    _controller?.close();
  }

  Future<Result> getPhotos(int id) {
    return photosRepo.getPhotos(id);
  }

  int getPhotosCount(PhotoList photoList) {
    return photoList.photos.length;
  }

  void onActionTap(ActionType actionType, Album album) {
    TapAction action;
    String toastMessage;
    if (actionType == ActionType.SaveToFavorites) {
      toastMessage = "${AppStrings.saveToFavoritesToastMessage} ${album.id}";
    } else {
      toastMessage = "${AppStrings.addCommentToastMessage} ${album.id}";
    }
    action = TapAction(actionType, album, toastMessage);
    _controller.add(action);
  }
}

class TapAction {
  final ActionType actionType;
  final Album album;
  final String toastMessage;

  TapAction(this.actionType, this.album, this.toastMessage);
}

enum ActionType { SaveToFavorites, AddComment }
