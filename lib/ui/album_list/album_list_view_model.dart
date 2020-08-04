import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/album_repo.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListViewModel {
  final AlbumListViewModelInput input;
  final AlbumsRepo _albumsRepo;
  AlbumListViewModelOutput output;

  AlbumListViewModel(this._albumsRepo, this.input) {
    Stream<Result<AlbumList>> onList = input.onStart.flatMap((_) {
      return _getAlbums();
    });

    Stream<NextScreen> nextScreen = input.onTap.map((album) {
      return NextScreen(ScreenType.AlbumDetails, album);
    });

    output = AlbumListViewModelOutput(onList, nextScreen);
  }

  Stream<Result<AlbumList>> _getAlbums() {
    return _albumsRepo.getAlbums().map((value) {
      if (value is SuccessState) {
        value.value.sortList();
      }
      return value;
    });
  }
}

class AlbumListViewModelInput {
  final Subject<Album> onTap;
  final Subject<bool> onStart;

  AlbumListViewModelInput(this.onTap, this.onStart);
}

class AlbumListViewModelOutput {
  final Stream<Result<AlbumList>> albums;
  final Stream<NextScreen> onNextScreen;

  AlbumListViewModelOutput(this.albums, this.onNextScreen);
}
