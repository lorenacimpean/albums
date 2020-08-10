import 'package:albums/themes/colors.dart';
import 'package:albums/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.darkBlue,
      primaryColorDark: AppColors.darkGrey,
      accentColor: AppColors.lightBlue,
      errorColor: AppColors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Nunito',
      textTheme: TextTheme(
        headline1: AppTextStyle.headline1,
        headline2: AppTextStyle.headline2,
        subtitle1: AppTextStyle.subtitle1,
        subtitle2: AppTextStyle.subtitle2,
        bodyText1: AppTextStyle.bodyText1,
        bodyText2: AppTextStyle.bodyText2,
        button: AppTextStyle.button,
      ),
    );
  }
}
