import 'package:albums/themes/paddings.dart';
import 'package:albums/widgets/back_button_widget.dart';
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
          Container(
            padding: EdgeInsets.only(
                top: AppPaddings.smallPadding,
                bottom: AppPaddings.smallPadding,
                left: AppPaddings.smallPadding),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    hasBackButton ? AppBackButton() : _title(context)
                  ],
                ),
                hasBackButton
                    ? Center(
                        child: _title(context),
                      )
                    : Container(),
              ],
            ),
          ),
          HorizontalSeparator(),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: AppPaddings.midPadding,
          bottom: AppPaddings.midLargePadding,
          left: AppPaddings.smallPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  @override
  Size get preferredSize => AppPaddings.appBarHeight;
}
