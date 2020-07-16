import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonText;

  const AppBackButton({
    Key key,
    @required this.onPressed,
    @required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(
        AppPaddings.defaultPadding,
      ),
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}
