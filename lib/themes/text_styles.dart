import 'package:albums/themes/colors.dart';
import 'package:albums/themes/text_sizes.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle headline1 = TextStyle(
      color: AppColors.darkGrey,
      fontSize: AppTextSizes.headline1,
      fontWeight: FontWeight.bold);

  static const TextStyle subtitle1 = TextStyle(
      color: AppColors.darkBlue,
      fontSize: AppTextSizes.subtitle1,
      fontWeight: FontWeight.bold);

  static const TextStyle subtitle2 = TextStyle(
      color: AppColors.darkGrey,
      fontSize: AppTextSizes.subtitle2,
      fontWeight: FontWeight.normal);

  static const TextStyle bodyText1 = TextStyle(
      color: AppColors.lightBlue,
      fontSize: AppTextSizes.bodyText,
      fontWeight: FontWeight.bold);

  static const TextStyle bodyText2 = TextStyle(
      color: AppColors.white,
      fontSize: AppTextSizes.bodyText,
      fontWeight: FontWeight.normal);
}
