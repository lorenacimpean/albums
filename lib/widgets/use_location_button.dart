import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UseMyLocationButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;

  const UseMyLocationButton(
      {Key key, @required this.onTap, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPaddings.largePadding),
      child: FlatButton(
        onPressed: onTap,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}
