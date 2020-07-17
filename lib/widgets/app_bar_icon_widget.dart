import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarIconWidget extends StatelessWidget {
  final GestureTapCallback onPressed;

  const AppBarIconWidget({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.all(AppPaddings.defaultPadding),
        child: InkWell(
          child: ImageIcon(
            AppIcons.notificationsIcon,
            color: Theme.of(context).primaryColor,
            size: AppPaddings.smallIconSize,
          ),
          onTap: () {
            if (onPressed != null) {
              onPressed();
            }
          },
        ),
      ),
    );
  }
}
