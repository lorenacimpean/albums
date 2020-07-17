import 'package:albums/themes/icons.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_header_info_widget.dart';
import 'package:albums/widgets/app_bar_widget.dart';
import 'package:albums/widgets/app_list_tile_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.profileTitle,
      buttonType: ButtonType.iconButton,
      onRightButtonTap: () {
        print("Tapped on icon");
      },
      key: Key(AppStrings.profileTitle),
      body: Column(
        children: <Widget>[
          AppHeaderInfo(),
          AppListTile(
            title: AppStrings.contactInfo,
            icon: AppIcons.contactInfoIcon,
            onTap: () {
              print("Tapped on Contact Info");
            },
          ),
        ],
      ),
    );
  }
}
