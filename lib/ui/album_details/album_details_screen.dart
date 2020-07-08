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
import 'package:albums/widgets/photos_in_album_widget.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:albums/widgets/vertical_separator_widget.dart';
import 'package:flutter/material.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Album album;

  const AlbumDetailsScreen({Key key, this.album}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AlbumDetailsScreenState();
}

class AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  PhotoListViewModel _viewModel;
  Future<Result> _futurePhotos;

  void initState() {
    super.initState();
    _viewModel = PhotoListViewModel(buildPhotosRepo());
    _futurePhotos = _viewModel.getPhotos(widget.album.id);
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
              return ListView.builder(
                shrinkWrap: true,
                itemCount: photos.photos.length,
                itemBuilder: (context, index) {
                  return index == 0
                      ? _iconWidgets(context)
                      : PhotoListTile(photoList: photos, index: index);
                },
              );
            } else if (snapshot.data is ErrorState) {
              return ErrorTextWidget(snapshot.error);
            } else
              return LoadingIndicator();
          }),
    );
  }

  Widget _iconWidgets(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: AppPaddings.albumDetailsWidgetPadding,
          height: AppPaddings.albumDetailsTitleContainerHeight,
          width: AppPaddings.albumDetailsScreenWidth,
          child: Center(
            child: Column(
              children: <Widget>[
                AlbumTitleWidget(album: widget.album),
                HorizontalSeparator(),
              ],
            ),
          ),
        ),
        Container(
          width: AppPaddings.albumDetailsScreenWidth,
          height: AppPaddings.albumDetailsIconsContainerHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AlbumActionWidget(
                      icon: AppIcons.saveToFavoritesIcon,
                      text: AppStrings.saveToFavorites),
                  VerticalSeparatorWidget(),
                  //TODO: replace with viewModel getCount
                  PhotosInAlbumWidget(
                    photosCount: 50,
                  ),
                  VerticalSeparatorWidget(),
                  AlbumActionWidget(
                      icon: AppIcons.addCommentIcon,
                      text: AppStrings.addComment),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: AppPaddings.albumDetailsScreenWidth,
          child: HorizontalSeparator(),
          padding: AppPaddings.albumDetailsWidgetPadding,
        ),
      ],
    );
  }
}
