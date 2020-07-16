import 'package:albums/data/model/albums.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

class AlbumListItemWidget extends StatelessWidget {
  final Album album;

  final GestureTapCallback onTap;

  const AlbumListItemWidget({Key key, @required this.album, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddings.extraSmallPadding),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppColors.lightGrey,
        ),
        borderRadius: AppPaddings.defaultRadius,
      ),
      margin: EdgeInsets.only(
          left: AppPaddings.defaultPadding, right: AppPaddings.defaultPadding),
      child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: ImageIcon(
              AppIcons.albumIcon,
              color: AppColors.darkBlue,
              size: AppPaddings.mediumIconSize,
            ),
          ),
          title: Text('${album.title}'),
          subtitle: Text('Album with id: ${album.id}'),
          trailing: ImageIcon(AppIcons.arrowIcon, color: AppColors.darkBlue),
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          }),
    );
  }
}
