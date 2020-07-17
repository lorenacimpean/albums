import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_bar_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/coming_soon_widget.dart';
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
        body: ComingSoonWidget());
  }
}
