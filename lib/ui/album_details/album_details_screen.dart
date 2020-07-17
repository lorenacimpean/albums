import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:albums/util/next_screen.dart';
import 'package:albums/widgets/album_details_icon_widgets.dart';
import 'package:albums/widgets/album_details_title_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/error_widget.dart';
import 'package:albums/widgets/horizontal_separator.dart';
import 'package:albums/widgets/photo_item_widget.dart';
import 'package:albums/widgets/photos_count_widget.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:albums/widgets/toast_widget.dart';
import 'package:albums/widgets/vertical_separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Album album;

  const AlbumDetailsScreen({Key key, @required this.album}) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  AlbumDetailsViewModel _viewModel;
  FlutterToast _flutterToast;
  Future<Result<List<ListItem>>> _futureListItem;
  StreamSubscription _onActionTapSubscription;
  StreamSubscription _nextScreenSubscription;

  void initState() {
    super.initState();
    _viewModel = AlbumDetailsViewModel(buildPhotosRepo());
    _flutterToast = FlutterToast(context);
    _futureListItem = _viewModel.getData(widget.album);
    _onActionTapSubscription = _viewModel.onTapStream.listen((action) {
      _showSnackBar(action.toastMessage);
    });
    _nextScreenSubscription = _viewModel.nextScreenStream.listen((nextScreen) {
      route(context, nextScreen);
    });
  }

  void dispose() {
    super.dispose();
    _nextScreenSubscription.cancel();
    _onActionTapSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.albumListTitle,
      hasBackButton: true,
      body: FutureBuilder(
          future: _futureListItem,
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              List<ListItem> _listItem =
                  (snapshot.data as SuccessState<List<ListItem>>).value;
              return ListView.builder(
                padding: EdgeInsets.all(AppPaddings.defaultPadding),
                shrinkWrap: true,
                itemCount: _listItem.length,
                itemBuilder: (context, index) {
                  return _listTile(context, _listItem[index]);
                },
              );
            } else if (snapshot.data is ErrorState) {
              return ErrorTextWidget(error: snapshot.error);
            } else
              return LoadingIndicator();
          }),
    );
  }

  //make this a custom widget? - no
  Widget _listTile(BuildContext context, ListItem listItem) {
    switch (listItem.type) {
      case ListItemType.albumInfo:
        return Column(
          children: <Widget>[
            AlbumTitleWidget(album: widget.album),
            HorizontalSeparator(),
          ],
        );
        break;
      case ListItemType.albumAction:
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
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
                  child: PhotosCountWidget(
                    photosCount: listItem.data,
                  ),
                ),
                VerticalSeparatorWidget(),
                Expanded(
                  child: AlbumActionWidget(
                    icon: AppIcons.addCommentIcon,
                    text: AppStrings.addComment,
                    onTap: () {
                      _viewModel.onActionTap(
                          ActionType.addComment, widget.album);
                    },
                  ),
                ),
              ],
            ),
            HorizontalSeparator(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPaddings.defaultPadding,
                  vertical: AppPaddings.midPadding),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.photos,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          ],
        );
        break;
      case ListItemType.photo:
        Photo photo = listItem.data;
        return PhotoListItem(
          photo: photo,
          onTap: () {
            _viewModel.onPhotoTap(photo);
          },
        );
        break;
    }
  }

  void _showSnackBar(String toastText) {
    _flutterToast.showToast(
      child: ToastWidget(
        toastMessage: toastText,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: AppPaddings.shortDuration,
    );
  }
}
