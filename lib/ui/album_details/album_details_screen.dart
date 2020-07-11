import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:albums/widgets/album_details_icon_widgets.dart';
import 'package:albums/widgets/album_details_title_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/error_widget.dart';
import 'package:albums/widgets/horizontal_separator.dart';
import 'package:albums/widgets/photo_list_tile_widget.dart';
import 'package:albums/widgets/photos_count_widget.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:albums/widgets/toast_widget.dart';
import 'package:albums/widgets/vertical_separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Album album;

  const AlbumDetailsScreen({Key key, this.album}) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  AlbumDetailsViewModel _viewModel;
  Future<Result> _futurePhotos;
  StreamSubscription _onActionTapSubscription;
  FlutterToast flutterToast;

  void initState() {
    super.initState();
    _viewModel = AlbumDetailsViewModel(buildPhotosRepo());
    _futurePhotos = _viewModel.getPhotos(widget.album);
    flutterToast = FlutterToast(context);
    _onActionTapSubscription =
        _viewModel.onTapController.stream.listen((action) {
      _showSnackBar(action.toastMessage);
    });
  }

  void dispose() {
    super.dispose();
    _onActionTapSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.albumListTitle,
      hasBackButton: true,
      body: FutureBuilder(
          future: _futurePhotos,
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              PhotoList photos = (snapshot.data as SuccessState).value;
              return Padding(
                padding: EdgeInsets.all(AppPaddings.defaultPadding),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: photos.photosCount(photos),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? _iconWidgets(context, photos)
                              : PhotoListTile(photoList: photos, index: index);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.data is ErrorState) {
              return ErrorTextWidget(error: snapshot.error);
            } else
              return LoadingIndicator();
          }),
    );
  }

  Widget _iconWidgets(BuildContext context, PhotoList photoList) {
    return Column(
      children: <Widget>[
        AlbumTitleWidget(album: widget.album),
        HorizontalSeparator(),
        Row(
          children: <Widget>[
            Expanded(
              flex: AppPaddings.defaultFlex,
              child: AlbumActionWidget(
                icon: AppIcons.saveToFavoritesIcon,
                text: AppStrings.saveToFavorites,
                onTap: () {
                  _viewModel.onActionTap(
                      ActionType.saveToFavorites, widget.album);
                },
              ),
            ),
            VerticalSeparatorWidget(),
            Expanded(
              flex: AppPaddings.defaultFlex,
              child: PhotosCountWidget(
                photosCount: photoList.photosCount(photoList),
              ),
            ),
            VerticalSeparatorWidget(),
            Expanded(
              flex: AppPaddings.defaultFlex,
              child: AlbumActionWidget(
                icon: AppIcons.addCommentIcon,
                text: AppStrings.addComment,
                onTap: () {
                  _viewModel.onActionTap(ActionType.addComment, widget.album);
                },
              ),
            ),
          ],
        ),
        HorizontalSeparator(),
      ],
    );
  }

  void _showSnackBar(String toastText) {
    flutterToast.showToast(
      child: ToastWidget(
        toastMessage: toastText,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: AppPaddings.shortDuration,
    );
  }
}
