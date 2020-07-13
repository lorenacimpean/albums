import 'dart:async';

import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:albums/ui/photo_screen/photo_screen.dart';
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

  const AlbumDetailsScreen({Key key, this.album}) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  AlbumDetailsViewModel _viewModel;
  FlutterToast _flutterToast;
  Future<Result> _futureListItem;
  List<ListItem> _listItem;
  StreamSubscription _onActionTapSubscription;
  StreamSubscription _nextScreenSubscription;

  void initState() {
    super.initState();
    _viewModel = AlbumDetailsViewModel(buildPhotosRepo());
    _flutterToast = FlutterToast(context);
    _futureListItem = _viewModel.getData(widget.album);
    _onActionTapSubscription =
        _viewModel.onTapController.stream.listen((action) {
      _showSnackBar(action.toastMessage);
    });
    _nextScreenSubscription = _viewModel.nextScreenController.stream.listen((photo) {
    route(photo);
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
              _listItem = (snapshot.data as SuccessState<List<ListItem>>).value;
              return Padding(
                padding: EdgeInsets.all(AppPaddings.defaultPadding),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _listItem.length,
                        itemBuilder: (context, index) {
                          print("index:$index");
                          return _listTile(context, _listItem[index]);
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
  //make this a custom widget?
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
        return Row(
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
                  _viewModel.onActionTap(ActionType.addComment, widget.album);
                },
              ),
            ),
          ],
        );
        break;
      case ListItemType.photo:
        Photo photo = listItem.data;
        return PhotoListItem(photo: photo,
          onTap: () {
          _viewModel.onPhotoTap(photo);
        },);
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

  route(Photo photo){
    Navigator.of(context).push(
        MaterialPageRoute(
        builder: (context) => PhotoScreen(photo: photo)));
  }
}
