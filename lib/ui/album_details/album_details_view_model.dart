import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/util/next_screen.dart';

enum ActionType { saveToFavorites, addComment }
enum ListItemType { albumInfo, albumAction, photo }

class AlbumDetailsViewModel {
  final PhotosRepo _photosRepo;
  final StreamController<TapAction> _onTapController =
      StreamController<TapAction>();
  final StreamController<NextScreen> _nextScreenController =
      StreamController<NextScreen>();

  Stream<NextScreen> get nextScreenStream => _nextScreenController.stream;

  Stream<TapAction> get onTapStream => _onTapController.stream;

  AlbumDetailsViewModel(this._photosRepo);

  void dispose() {
    _onTapController.close();
    _nextScreenController.close();
  }

  Future<Result<List<ListItem>>> getData(Album album) {
    return _photosRepo.getPhotoList(album.id).then((result) {
      if (result is SuccessState) {
        (result as SuccessState).value;
        List<ListItem> itemList = [];
        if (result is SuccessState<PhotoList>) {
          ListItem albumInfo = ListItem(
              type: ListItemType.albumInfo,
              data: AlbumInfo(
                  albumName: album.title,
                  albumId: album.id,
                  photosCount: result.value.photosCount()));
          itemList.add(albumInfo);

          ListItem albumAction = ListItem(
              type: ListItemType.albumAction, data: albumInfo.data.photosCount);
          itemList.add(albumAction);

          itemList.addAll((result as SuccessState<PhotoList>)
              .value
              .photos
              .map((e) => ListItem(type: ListItemType.photo, data: e)));
        }
        return Result.success(itemList);
      } else if (result is ErrorState) {
        return Result.error((result as ErrorState<PhotoList>).msg);
      }
      return Result.loading(null);
    });
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
    _onTapController.add(action);
  }

  void onPhotoTap(Photo photo) {
    NextScreen nextScreen = NextScreen(ScreenType.Photo, photo);
    _nextScreenController.add(nextScreen);
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

  @override
  int get hashCode => type.hashCode ^ data.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItem && type == other.type && data == other.data;
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
