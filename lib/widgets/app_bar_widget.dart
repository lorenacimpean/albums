import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_bar_title_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
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
    rowItems.add(
      Expanded(
        flex: AppPaddings.mediumFlex,
        child: Padding(
          padding: EdgeInsets.all(AppPaddings.defaultPadding),
          child: AppBarTitle(title: title),
        ),
      ),
    );
    if (hasBackButton) {
      rowItems.insert(
        0,
        Expanded(
            child: AppTextButton(
                onPressed: () => Navigator.pop(context),
                buttonText: AppStrings.backButtonText)),
      );
    }
    if (buttonType != null) {
      if (buttonType == ButtonType.textButton) {
        rowItems.add(
          Expanded(
              child: AppTextButton(
                  onPressed: () => Navigator.pop(context),
                  buttonText: AppStrings.apply)),
        );
      } else {
        rowItems.add(AppBarIconWidget(onPressed: onRightButtonTap));
      }
    }
    return rowItems;
  }

  @override
  Size get preferredSize => AppPaddings.appBarHeight;
}
