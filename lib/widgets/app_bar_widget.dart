import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_bar_title_widget.dart';
import 'package:albums/widgets/horizontal_separator.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final List<Widget> rightWidgets;

  const CustomAppBar(
      {Key key,
      @required this.title,
      this.hasBackButton = false,
      this.rightWidgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: _buildStack(context),
      ),
    );
  }

  List<Widget> _buildStack(BuildContext context) {
    List<Widget> stackItems = [];
    if (hasBackButton) {
      stackItems.add(Align(
        alignment: Alignment.centerLeft,
        child: AppTextButton(
            onPressed: () => Navigator.pop(context),
            buttonText: AppStrings.backButtonText),
      ));
    }
    stackItems.add(Align(
      alignment: hasBackButton ? Alignment.center : Alignment.centerLeft,
      child: AppBarTitle(
        title: title,
      ),
    ));
    stackItems.add(
      Align(
        alignment: Alignment.centerRight,
        child: Stack(
          children: rightWidgets,
        ),
      ),
    );
    stackItems.add(
      Align(
        alignment: Alignment.bottomCenter,
        child: HorizontalSeparator(),
      ),
    );
    return stackItems;
  }

  @override
  Size get preferredSize => AppPaddings.appBarHeight;
}
