import 'package:albums/themes/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalSeparator extends StatelessWidget {
  const HorizontalSeparator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      height: AppPaddings.separatorSize,
      padding: EdgeInsets.only(
          left: AppPaddings.defaultPadding, right: AppPaddings.defaultPadding),
    );
  }
}
