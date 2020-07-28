import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/album_repo.dart';
import 'package:albums/ui/next_screen.dart';

class AlbumListViewModel {
  final AlbumsRepo _albumsRepo;
  StreamController<NextScreen> goToNext = StreamController();

  AlbumListViewModel(this._albumsRepo);

  void dispose() {
    goToNext.close();
  }

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
