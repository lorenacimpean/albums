import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(
          top: AppPaddings.midPadding,
          bottom: AppPaddings.defaultPadding,
          left: AppPaddings.defaultPadding),
      child: Text(
        AppStrings.backButtonText,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
