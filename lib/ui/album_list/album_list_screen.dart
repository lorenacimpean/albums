import 'dart:core';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/ui/photo_list_screen/photos_list_screen.dart';
import 'package:albums/widgets/album_list_item_widget.dart';
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
              _viewModel.sortAlbums(albums);

              return ListView.separated(
                itemBuilder: (context, index) {
                  Album currentAlbum = _viewModel.albumAtIndex(albums, index);
                  return AlbumListItemWidget(
                    index: index,
                    albums: albums,
                    onTap: () => _viewModel.goToNext().then((_) => route(currentAlbum)),
                    key: Key(currentAlbum.id.toString()),
                  );
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

  route(Album album) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => PhotoListScreen(album: album)));
    
  }
}
