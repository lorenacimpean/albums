import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/themes/strings.dart';

enum ActionType { saveToFavorites, addComment }
enum ListItemType { albumInfo, albumAction, photo }

class AlbumDetailsViewModel {
  final PhotosRepo photosRepo;
  StreamController<TapAction> onTapController = StreamController<TapAction>();

  AlbumDetailsViewModel(this.photosRepo);

  Future<Result> getPhotos(Album album) {
    return photosRepo.getPhotoList(album.id);
  }

  Future<Result<List<ListItem>>> getData(Album album, ListItemType type) {
    List<ListItem> listItems;
    switch (type) {
      case ListItemType.albumInfo:
        getPhotos(album).then((photolist) {
          PhotoList result = photolist as PhotoList;
          result.photos.forEach((photo) {
            AlbumInfo albumDetails = AlbumInfo(
                albumName: album.title,
                albumId: album.id,
                photosCount: result.photos.length);
            ListItem item =
                ListItem(type: ListItemType.albumInfo, data: albumDetails);
            listItems.add(item);
          });
        });
        break;
      case ListItemType.albumAction:
        // TODO: Handle this case.
        break;
      case ListItemType.photo:

        break;
    }
  }


  int getPhotosCount(PhotoList photoList) {
    return photoList.photos.length;
  }

  void onActionTap(ActionType actionType, Album album) {
    TapAction action;
    String toastMessage;
    if (actionType == ActionType.saveToFavorites) {
      toastMessage = "${AppStrings.saveToFavoritesToastMessage} ${album.id}";
    } else {
      toastMessage = "${AppStrings.addCommentToastMessage} ${album.id}";
    }
    action = TapAction(actionType, album, toastMessage);
    onTapController.add(action);
  }
}

class TapAction {
  final ActionType actionType;
  final Album album;
  final String toastMessage;

  TapAction(this.actionType, this.album, this.toastMessage);
}

class ListItem {
  final ListItemType type;
  final dynamic data;

  ListItem({this.type, this.data});
}

class AlbumInfo {
  final String albumName;
  final int albumId;
  final int photosCount;

  AlbumInfo({
    this.albumName,
    this.albumId,
    this.photosCount,
  });
}
