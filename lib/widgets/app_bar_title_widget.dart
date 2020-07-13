import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: AppPaddings.midPadding,
          bottom: AppPaddings.midLargePadding,
          left: AppPaddings.smallPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

}
