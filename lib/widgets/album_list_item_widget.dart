import 'package:albums/data/model/albums.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

class AlbumListItemWidget extends StatelessWidget {
  final int index;
  final AlbumList albums;
  final GestureTapCallback onTap;

  const AlbumListItemWidget({Key key, this.albums, this.index, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onTap();
          }),
    );
  }
}
