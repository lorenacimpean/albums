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
        padding: EdgeInsets.symmetric(vertical: AppPaddings.defaultPadding,
        horizontal: AppPaddings.extraLargePadding ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          borderRadius: AppPaddings.defaultRadius,
        ),
        child: Text(AppStrings.comingSoon,
            style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
