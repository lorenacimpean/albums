import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/coming_soon_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:flutter/widgets.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.notifications,
      hasBackButton: true,
      rightButtons: <Widget>[
        AppTextButton(
          buttonText: AppStrings.apply,
          onPressed: () => print("Tapped on Apply"),
        )
      ],
      key: Key(AppStrings.notifications),
      body: ComingSoonWidget(),
    );
  }
}
