import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/coming_soon_widget.dart';
import 'package:flutter/cupertino.dart';

class FriendsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.friendsTitle,
      key: Key(AppStrings.friendsTitle),
      body: ComingSoonWidget(),
    );
  }
}
