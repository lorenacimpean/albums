import 'package:albums/themes/colors.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppPaddings.defaultHeight,
        width: AppPaddings.defaultWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          borderRadius: AppPaddings.albumTileRadius,
        ),
        child: Text(AppStrings.comingSoon,
            style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
