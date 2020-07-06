import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';

enum ScreenType { AlbumDetails, Other }

class AlbumListViewModel {
  final AlbumsRepo _albumsRepo;
  StreamController<NextScreen> goToNext = StreamController();

  AlbumListViewModel(this._albumsRepo);

  Future<Result> getAlbums() {
    Future<Result> futureAlbumList = _albumsRepo.getAlbums();

    futureAlbumList.then((value) {
      if (value is SuccessState) {
        SuccessState<AlbumList> albums = value as SuccessState;
        albums.value.sortList();
      }
      return value;
    });
    return futureAlbumList;
  }

  void onAlbumTap(Album album) {
    NextScreen nextScreen = NextScreen(ScreenType.AlbumDetails, album);
    goToNext.add(nextScreen);
  }
}

class NextScreen {
  final ScreenType type;
  final dynamic data;

  NextScreen(this.type, this.data);
}
