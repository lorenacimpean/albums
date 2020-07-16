import 'package:albums/data/model/albums.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';
import 'package:albums/util/extensions.dart';

class AlbumTitleWidget extends StatelessWidget {
  final Album album;

  const AlbumTitleWidget({Key key, @required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ImageIcon(
                AppIcons.albumTitle,
                color: AppColors.darkBlue,
                size: AppPaddings.defaultIconSize,
              ),
              Text(album.title.firstLetterToUpperCase()),
            ],
          ),
          Container(
              padding: EdgeInsets.all(AppPaddings.smallPadding),
              child: Text('${album.title}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1)),
          Container(
              padding: EdgeInsets.all(AppPaddings.smallPadding),
              child: Text('${AppStrings.albumWithId}: ${album.id}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2)),
        ],
      ),
    );
  }
}
