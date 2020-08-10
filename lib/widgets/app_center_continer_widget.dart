import 'package:albums/themes/colors.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';

class AppCenterContainerWidget extends StatelessWidget {
  final Color textColor;
  final Color borderColor;
  final String text;

  const AppCenterContainerWidget({
    Key key,
    this.textColor = AppColors.darkBlue,
    this.borderColor = AppColors.lightGrey,
    this.text = AppStrings.comingSoon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppPaddings.defaultPadding,
            horizontal: AppPaddings.extraLargePadding),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: AppPaddings.defaultRadius,
        ),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: textColor)),
      ),
    );
  }
}
