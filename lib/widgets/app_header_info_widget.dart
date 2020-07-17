import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';

class AppHeaderInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconText;

  const AppHeaderInfo(
      {Key key,
      this.title = AppStrings.unknown,
      this.subtitle = "",
      this.iconText = AppStrings.questionMark})
      : super(key: key);

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
              Text(iconText, style: Theme.of(context).textTheme.headline1),
            ],
          ),
          Container(
              padding: EdgeInsets.all(AppPaddings.smallPadding),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2)),
          Container(
              padding: EdgeInsets.all(AppPaddings.smallPadding),
              child: Text(subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2)),
        ],
      ),
    );
  }
}
