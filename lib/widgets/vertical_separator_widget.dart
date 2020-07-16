import 'package:albums/themes/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalSeparatorWidget extends StatelessWidget {
  const VerticalSeparatorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: AppPaddings.defaultPadding, bottom: AppPaddings.defaultPadding),
      color: Theme.of(context).primaryColorDark,
      width: AppPaddings.separatorSize,
    );
  }
}
