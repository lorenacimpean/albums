import 'package:albums/themes/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final TextAlign textAlignment;

  const AppBarTitle({
    Key key,
    @required this.title,
    this.textAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(AppPaddings.defaultPadding),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
          textAlign: textAlignment,
        ),
      ),
    );
  }
}
