import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albums_repo_factory.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/transitions/fade_route.dart';
import 'package:albums/ui/photo_list_screen/photos_list_screen.dart';
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

  void initState() {
    super.initState();
    _viewModel = AlbumListViewModel(buildAlbumsRepo());
    _futureAlbums = _viewModel.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _albumList(context),
    );
  }

  Widget _albumList(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: _futureAlbums,
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              AlbumList albums = (snapshot.data as SuccessState).value;
              albums.sortList();
              // albums.sortList();
              return ListView.separated(
                itemBuilder: (context, index) {
                  return _albumListItem(index, albums, context);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: AppPaddings.separatorHeight,
                  );
                },
                itemCount: albums.albumList.length,
                physics: BouncingScrollPhysics(),
              );
            } else if (snapshot.data is ErrorState) {
              return ErrorTextWidget(snapshot.error);
            } else
              return LoadingIndicator();
          }),
    );
  }

  StatelessWidget _albumListItem(
      int index, AlbumList albums, BuildContext context) {
    Album currentAlbum = albums.albumAtIndex(index);

    return Container(
      padding: AppPaddings.listItemPadding,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppColors.lightGrey,
        ),
        borderRadius: AppPaddings.albumTileRadius,
      ),
      margin: AppPaddings.listItemMargin,
      child: ListTile(
          leading: Container(
            width: AppPaddings.blueContainerSize,
            height: AppPaddings.blueContainerSize,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: ImageIcon(
              AppIcons.albumIcon,
              color: AppColors.darkBlue,
            ),
          ),
          title: Text('${currentAlbum.title}'),
          subtitle: Text('Album with id: ${currentAlbum.id}'),
          trailing: ImageIcon(AppIcons.arrowIcon, color: AppColors.darkBlue),
          onTap: () {
            _openAlbumDetailsScreen(context, currentAlbum);
          }),
    );
  }

  void _openAlbumDetailsScreen(BuildContext context, Album album) {
    Navigator.push(context, FadeRoute(page: PhotoListScreen(album: album)));
  }
}
