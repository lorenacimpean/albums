import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:albums/widgets/app_center_continer_widget.dart';
import 'package:albums/widgets/app_list_tile_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/base_state.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'album_list_view_model.dart';

class AlbumListScreen extends StatefulWidget {
  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends BaseState<AlbumListScreen> {
  AlbumListViewModel _viewModel;
  Result<AlbumList> _result;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.albumListTitle,
      key: Key(AppStrings.albumListTitle),
      body: _albumList(context),
    );
  }

  void initState() {
    super.initState();
    _viewModel = AlbumListViewModel(
      buildAlbumsRepo(),
      AlbumListViewModelInput(
        PublishSubject(),
        PublishSubject(),
      ),
    );

    disposeLater(
      _viewModel.output.albums.listen((albumList) {
        setState(() {
          _result = albumList;
          if (albumList is SuccessState<AlbumList>) {
            (_result as SuccessState).value = albumList.value;
          }
        });
      }, onError: (e) {
            handleError(
                error: e,
                retry: () {
                  Navigator.pop(context);
                  _viewModel.input.onStart.add(true);
                });
      }),
    );
    _viewModel.output.onNextScreen.listen((nextScreen) {
      openNextScreen(context, nextScreen);
    });
    _viewModel.input.onStart.add(true);
  }

  Widget _albumList(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: AppPaddings.defaultPadding),
        child: _buildBody(context));
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Album currentAlbum =
            (_result as SuccessState).value.albumAtIndex(index);
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
      itemCount: (_result as SuccessState).value.albumList.length,
      physics: BouncingScrollPhysics(),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_result is LoadingState) {
      return LoadingIndicator();
    }
    if (_result is SuccessState) {
      return _buildListView(context);
    }
    return AppCenterContainerWidget(
      text: AppStrings.errorWhileLoading,
      textColor: AppColors.red,
      borderColor: AppColors.red,
    );
  }
}
