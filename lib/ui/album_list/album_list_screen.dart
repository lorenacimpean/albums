import 'dart:async';
import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/album_details_screen.dart';
import 'package:albums/widgets/album_list_item_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/error_widget.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';

import 'album_list_view_model.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  AlbumListViewModel _viewModel;
  Future<Result> _futureAlbums;
  StreamSubscription _nextScreenSubscription;

  void initState() {
    super.initState();
    _viewModel = AlbumListViewModel(buildAlbumsRepo());
    _futureAlbums = _viewModel.getAlbums();
    _nextScreenSubscription = _viewModel.goToNext.stream.listen((nextScreen) {
      route(nextScreen);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nextScreenSubscription.cancel();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.albumListTitle,
      key: Key(AppStrings.albumListTitle),
      body: _albumList(context),
    );
  }

  Widget _albumList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppPaddings.defaultPadding),
      child: Center(
        child: FutureBuilder(
            future: _futureAlbums,
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                AlbumList albums = (snapshot.data as SuccessState).value;

                return ListView.separated(
                  itemBuilder: (context, index) {
                    Album currentAlbum = albums.albumAtIndex(index);
                    return AlbumListItemWidget(
                      album: currentAlbum,
                      onTap: () {
                        _viewModel.onAlbumTap(currentAlbum);
                      },
                      key: Key(currentAlbum.id.toString()),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: AppPaddings.midPadding,
                    );
                  },
                  itemCount: albums.albumList.length,
                  physics: BouncingScrollPhysics(),
                );
              } else if (snapshot.data is ErrorState) {
                return ErrorTextWidget(error: snapshot.error);
              } else
                return LoadingIndicator();
            }),
      ),
    );
  }

  route(NextScreen nextScreen) {
    switch (nextScreen.type) {
      case ScreenType.AlbumDetails:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                AlbumDetailsScreen(album: nextScreen.data)));
        break;
      case ScreenType.Other:
        // TODO: Handle this case.
        break;
    }
  }
}
