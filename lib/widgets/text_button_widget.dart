import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonText;

  const AppTextButton(
      {Key key, @required this.onPressed, @required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.all(AppPaddings.defaultPadding),
        child: InkWell(
          child: Text(buttonText, style: Theme.of(context).textTheme.subtitle1),
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
