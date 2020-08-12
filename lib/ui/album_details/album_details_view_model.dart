import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/tap_action_model.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:rxdart/rxdart.dart';

import 'album_info_model.dart';
import 'gallery_details_model.dart';
import 'list_item_model.dart';

enum ActionType { saveToFavorites, addComment }
enum ListItemType { albumInfo, albumAction, photo }

class AlbumDetailsViewModel {
  final PhotosRepo _photosRepo;
  final AlbumDetailsViewModelInput input;
  AlbumDetailsViewModelOutput output;
  PhotoList _photoList;

  AlbumDetailsViewModel(this._photosRepo, this.input) {
    Stream<Result<ListItems>> onList = input.onStart.flatMap((album) {
      return _getListItemList(album);
    });
    Stream<NextScreen> onNextScreen = input.onPhotoTap.flatMap((photo) {
      return _onPhotoTap(photo);
    });
    Stream<TapAction> onToast = input.onActionTap.flatMap((tapAction) {
      return _onActionTap(tapAction);
    });
    output = AlbumDetailsViewModelOutput(onList, onNextScreen, onToast);
  }

  Stream<Result<ListItems>> _getListItemList(Album album) {
    return _photosRepo.getPhotoList(album.id).map((result) {
      if (result is SuccessState<PhotoList>) {
        _photoList = result.value;
        List<ListItem> itemList = [];
        ListItem albumInfo = ListItem(
          type: ListItemType.albumInfo,
          data: AlbumInfo(
            albumName: album.title,
            albumId: album.id,
            photosCount: _photoList.photosCount(),
          ),
        );
        itemList.add(albumInfo);
        ListItem albumAction = ListItem(
          type: ListItemType.albumAction,
          data: _photoList.photosCount(),
        );
        itemList.add(albumAction);
        itemList.addAll(
          (result.value.photos.map(
            (e) => ListItem(type: ListItemType.photo, data: e),
          )),
        );
        ListItems items = ListItems(itemList);
        return Result<ListItems>.success(items);
      }
      return Result<ListItems>.error(AppStrings.photoListError);
    }).startWith(Result<ListItems>.loading(null));
  }

  Stream<TapAction> _onActionTap(TapAction tapAction) {
    TapAction action;
    String toastMessage;
    if (tapAction.actionType == ActionType.saveToFavorites) {
      toastMessage =
          "${AppStrings.saveToFavoritesToastMessage} ${tapAction.album.id}";
    } else {
      toastMessage =
          "${AppStrings.addCommentToastMessage} ${tapAction.album.id}";
    }
    action = TapAction(
        actionType: tapAction.actionType,
        album: tapAction.album,
        toastMessage: toastMessage);
    return Stream.value(action);
  }

  Stream<NextScreen> _onPhotoTap(Photo selectedPhoto) {
    int selectedPhotoIndex = _photoList.selectedIndex(selectedPhoto);
    NextScreen nextScreen = NextScreen(
        ScreenType.Photos,
        GalleryDetails(
          photoList: _photoList,
          selectedIndex: selectedPhotoIndex,
        ));
    return Stream.value(nextScreen);
  }
}

class AlbumDetailsViewModelInput {
  final Subject<TapAction> onActionTap;
  final Subject<Photo> onPhotoTap;
  final Subject<Album> onStart;

  AlbumDetailsViewModelInput(
    this.onActionTap,
    this.onPhotoTap,
    this.onStart,
  );
}

class AlbumDetailsViewModelOutput {
  final Stream<Result<ListItems>> listItems;
  final Stream<NextScreen> nextScreen;
  final Stream<TapAction> toast;

  AlbumDetailsViewModelOutput(
    this.listItems,
    this.nextScreen,
    this.toast,
  );
}
