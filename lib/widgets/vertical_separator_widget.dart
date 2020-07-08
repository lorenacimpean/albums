import 'package:albums/themes/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalSeparatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      height: AppPaddings.defaultHeight,
      child: VerticalDivider(
        width: AppPaddings.separatorSize,
      ),
    );
  }
}
