import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_bar_title_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:albums/widgets/horizontal_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackButton;
  final String title;

  const CustomAppBar(
      {Key key, @required this.title, this.hasBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          hasBackButton
              ? Row(
                  children: <Widget>[
                    Expanded(
                        child: AppTextButton(
                            onPressed: () => Navigator.pop(context),
                            buttonText: AppStrings.backButtonText)),
                    Expanded(
                        flex: AppPaddings.mediumFlex,
                        child: AppBarTitle(title: title))
                  ],
                )
              : Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.symmetric(
                      vertical: AppPaddings.defaultPadding),
                  child: AppBarTitle(title: title)),
          HorizontalSeparator(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => AppPaddings.appBarHeight;
}
