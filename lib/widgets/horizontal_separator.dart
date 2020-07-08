import 'package:albums/themes/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        color: Theme.of(context).primaryColorDark,
        height: AppPaddings.separatorSize,
        padding: AppPaddings.albumDetailsWidgetPadding);
  }
}
