import 'package:albums/themes/colors.dart';
import 'package:albums/themes/text_sizes.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle navBarDefault = TextStyle(
      color: AppColors.lightBlue,
      fontSize: AppTextSizes.navBarTextSize,
      fontWeight: FontWeight.bold);

  static const TextStyle navBarSelected = TextStyle(
      color: AppColors.lightBlue,
      fontSize: AppTextSizes.navBarTextSize,
      fontWeight: FontWeight.bold);

  static const TextStyle albumTitle = TextStyle(
      color: AppColors.darkBlue,
      fontSize: AppTextSizes.albumTitleTextSize,
      fontWeight: FontWeight.bold);

  static const TextStyle albumId = TextStyle(
      color: AppColors.darkGrey,
      fontSize: AppTextSizes.albumIdTextSize,
      fontWeight: FontWeight.normal);
}
