import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppListTile extends StatelessWidget {
  final AssetImage icon;
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;

  const AppListTile(
      {Key key,
      @required this.icon,
      @required this.title,
      this.subtitle = "",
      @required this.onTap})
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
              icon,
              color: AppColors.darkBlue,
              size: AppPaddings.mediumIconSize,
            ),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: ImageIcon(AppIcons.arrowIcon, color: AppColors.darkBlue),
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          }),
    );
  }
}
