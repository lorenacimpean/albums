import 'dart:ui';

import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_bar_title_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_bar_icon_widget.dart';
import 'horizontal_separator.dart';

enum ButtonType { iconButton, textButton }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final ButtonType buttonType;
  final GestureTapCallback onRightButtonTap;

  const CustomAppBar(
      {Key key,
      @required this.title,
      this.hasBackButton = false,
      this.buttonType,
      this.onRightButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: _buildRow(context),
          ),
          HorizontalSeparator(),
        ],
      ),
    );
  }

  List<Widget> _buildRow(BuildContext context) {
    List<Widget> rowItems = [];
    if (hasBackButton) {
      rowItems.add(
        AppTextButton(
            onPressed: () => Navigator.pop(context),
            buttonText: AppStrings.backButtonText),
      );
    }
    rowItems.add(
      AppBarTitle(
        title: title,
        textAlignment: hasBackButton ? TextAlign.center : TextAlign.start,
      ),
    );
    if (buttonType != null) {
      buttonType == ButtonType.textButton
          ? rowItems.add(
              AppTextButton(
                  onPressed: () => onRightButtonTap,
                  buttonText: AppStrings.apply),
            )
          : rowItems.add(
              AppBarIconWidget(onPressed: onRightButtonTap),
            );
    }
    return rowItems;
  }

  @override
  Size get preferredSize => AppPaddings.appBarHeight;
}
