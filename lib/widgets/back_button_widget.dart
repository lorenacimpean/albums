import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: AppPaddings.appBarButtonPadding,
      child: FlatButton(
        child: Text(
          AppStrings.backButtonText,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
