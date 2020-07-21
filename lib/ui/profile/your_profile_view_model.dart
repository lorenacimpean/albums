import 'dart:async';

import 'package:albums/util/next_screen.dart';

class YourProfileViewModel {
  StreamController<NextScreen> _nextScreenController =
      StreamController<NextScreen>();
  Future<bool> userProfileSaved;

  Stream<NextScreen> get nextScreenStream => _nextScreenController.stream;

  void onContactInfoTapped() {
    NextScreen nextScreen =
        NextScreen(ScreenType.ContactInfo, userProfileSaved);
    _nextScreenController.add(nextScreen);
  }

  void onNotificationIconTapped() {
    NextScreen nextScreen = NextScreen(ScreenType.NotificationsScreen, null);
    _nextScreenController.add(nextScreen);
  }
}
