import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRoundedTextButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;

  const AppRoundedTextButton(
      {Key key, @required this.onTap, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
