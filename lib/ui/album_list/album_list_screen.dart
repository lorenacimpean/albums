import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:albums/widgets/app_list_tile_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/error_handling_state.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'album_list_view_model.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends ErrorHandlingState<AlbumListScreen> {
  AlbumListViewModel _viewModel;
  AlbumList _albums = AlbumList();

  void initState() {
    super.initState();
    _viewModel = AlbumListViewModel(
        buildAlbumsRepo(),
        AlbumListViewModelInput(
          PublishSubject(),
          PublishSubject(),
        ));

    disposeLater(
      _viewModel.output.albums.listen((result) {
        setState(() {
          if (result is ErrorState) {
            handleError(result);
          }
          if (result is SuccessState) {
            _albums = result.value;
          }
        });
      }),
    );
    _viewModel.output.onNextScreen.listen((nextScreen) {
      openNextScreen(context, nextScreen);
    });
    _viewModel.input.onStart.add(true);
  }

  @override
  void dispose() {
    super.dispose();
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
        child: ListView.separated(
          itemBuilder: (context, index) {
            Album currentAlbum = _albums.albumAtIndex(index);
            return AppListTile(
              icon: AppIcons.albumIcon,
              title: currentAlbum.title,
              subtitle: '${AppStrings.albumWithId} ${currentAlbum.id}',
              onTap: () {
                _viewModel.input.onTap.add(currentAlbum);
              },
              key: Key(currentAlbum.id.toString()),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: AppPaddings.midPadding,
            );
          },
          itemCount: _albums.albumList.length,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
