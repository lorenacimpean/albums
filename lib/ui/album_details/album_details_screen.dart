import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:albums/ui/album_details/tap_action_model.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/widgets/album_details_icon_widgets.dart';
import 'package:albums/widgets/app_center_continer_widget.dart';
import 'package:albums/widgets/app_header_info_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/base_state.dart';
import 'package:albums/widgets/horizontal_separator.dart';
import 'package:albums/widgets/photo_item_widget.dart';
import 'package:albums/widgets/photos_count_widget.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:albums/widgets/toast_widget.dart';
import 'package:albums/widgets/vertical_separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../next_screen.dart';
import 'list_item_model.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Album album;

  const AlbumDetailsScreen({Key key, @required this.album}) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends BaseState<AlbumDetailsScreen> {
  AlbumDetailsViewModel _viewModel;
  FlutterToast _flutterToast;
  Result<ListItems> _result;

  void initState() {
    super.initState();
    _viewModel = AlbumDetailsViewModel(
        buildPhotosRepo(),
        AlbumDetailsViewModelInput(
          BehaviorSubject(),
          BehaviorSubject(),
          BehaviorSubject(),
        ));
    _flutterToast = FlutterToast(context);

    disposeLater(
      _viewModel.output.listItems.listen((listItems) {
        _result = listItems;
        setState(() {
          if (listItems is SuccessState<ListItems>) {
            (_result as SuccessState).value = listItems.value;
          }
        });
      }, onError: (e) {
        debugPrint(e.toString());
        handleError(
            error: e,
            retry: () {
              _viewModel.input.onStart.add(widget.album);
              Navigator.pop(context);
            });
      }),
    );
    _viewModel.output.nextScreen.listen((nextScreen) {
      openNextScreen(context, nextScreen);
    });
    _viewModel.output.toast.listen((tapAction) {
      _showSnackBar(tapAction.toastMessage);
    });
    _viewModel.input.onStart.add(widget.album);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.albumListTitle,
      hasBackButton: true,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_result is LoadingState<ListItems>) {
      return LoadingIndicator();
    }
    if (_result is SuccessState<ListItems>) {
      return ListView.builder(
        padding: EdgeInsets.all(AppPaddings.defaultPadding),
        shrinkWrap: true,
        itemCount: (_result as SuccessState<ListItems>).value.listItems.length,
        itemBuilder: (context, index) {
          return _listTile(context,
              (_result as SuccessState<ListItems>).value.listItems[index]);
        },
      );
    }
    return AppCenterContainerWidget(
      text: AppStrings.errorWhileLoading,
      textColor: AppColors.red,
      borderColor: AppColors.red,
    );
  }

  Widget _listTile(BuildContext context, ListItem listItem) {
    Album _currentAlbum = widget.album;
    switch (listItem.type) {
      case ListItemType.albumInfo:
        return Column(
          children: <Widget>[
            AppHeaderInfo(
              title: _currentAlbum.title,
              subtitle: '${AppStrings.albumWithId}: ${_currentAlbum.id}',
              iconText: _currentAlbum.title.firstLetterToUpperCase(),
            ),
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
                      _viewModel.input.onActionTap.add(
                        TapAction(
                          actionType: ActionType.saveToFavorites,
                          album: widget.album,
                        ),
                      );
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
                      _viewModel.input.onActionTap.add(
                        TapAction(
                          actionType: ActionType.addComment,
                          album: widget.album,
                        ),
                      );
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
            _viewModel.input.onPhotoTap.add(photo);
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
