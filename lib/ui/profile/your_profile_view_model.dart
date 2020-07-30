import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/ui/next_screen.dart';

class YourProfileViewModel {
  final UserProfileRepo _userProfileRepo;

  YourProfileViewModel(this._userProfileRepo);

  StreamController<NextScreen> _nextScreenController =
      StreamController<NextScreen>();

  Stream<NextScreen> get nextScreenStream => _nextScreenController.stream;

  void onContactInfoTapped() {
    NextScreen nextScreen = NextScreen(ScreenType.ContactInfo, userProfile);
    _nextScreenController.add(nextScreen);
  }

  void onNotificationIconTapped() {
    NextScreen nextScreen = NextScreen(ScreenType.NotificationsScreen, null);
    _nextScreenController.add(nextScreen);
  }

  Stream<Result<ContactInfo>> userProfile() {
    return _userProfileRepo.fetchContactInfo();
  }
}
