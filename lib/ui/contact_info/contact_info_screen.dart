import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_bar_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:flutter/material.dart';

class ContactInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.contactInfo,
      hasBackButton: true,
      buttonType: ButtonType.textButton,
      body: Container(),
    );
  }
}
