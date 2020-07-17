import 'dart:async';
import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/util/next_screen.dart';
import 'package:albums/widgets/app_list_tile_widget.dart';
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
      route(context, nextScreen);
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
                    return AppListTile(
                      icon: AppIcons.albumIcon,
                      title: currentAlbum.title,
                      subtitle: '${AppStrings.albumWithId} ${currentAlbum.id}',
                      onTap: () => _viewModel.onAlbumTap(currentAlbum),
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
}
