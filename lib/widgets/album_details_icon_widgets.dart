import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

class AlbumActionWidget extends StatelessWidget {
  final AssetImage icon;
  final String text;
  final VoidCallback onTap;

  const AlbumActionWidget(
      {Key key, @required this.icon, @required this.text, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(AppPaddings.defaultPadding),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageIcon(
            icon,
            color: Theme.of(context).primaryColor,
            size: AppPaddings.smallIconSize,
          ),
          Text(text,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
