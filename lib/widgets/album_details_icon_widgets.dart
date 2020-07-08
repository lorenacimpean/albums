import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

class AlbumActionWidget extends StatelessWidget {
  final AssetImage icon;
  final String text;

  final VoidCallback onTap;

  const AlbumActionWidget(
      {Key key, @required this.icon, @required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      child: Expanded(
        flex: AppPaddings.albumDetailsWidgetIconFlex,
        child: Column(
          children: <Widget>[
            ImageIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: AppPaddings.albumDetailsIconButtonSize,
            ),
            Text(text, style: Theme.of(context).textTheme.subtitle2),
          ],
        ),
      ),
    );
  }
}
