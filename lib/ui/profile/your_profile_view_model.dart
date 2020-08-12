import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:rxdart/rxdart.dart';

class YourProfileViewModel {
  final UserProfileRepo _userProfileRepo;
  final YourProfileViewModelInput input;
  YourProfileViewModelOutput output;
  ContactInfo _contactInfo;

  YourProfileViewModel(
    this._userProfileRepo,
    this.input,
  ) {
    Stream<ContactInfo> onContactInfo = input.onStart.flatMap((_) {
      return _getUserProfile().map((info) {
        return info ?? _contactInfo;
      });
    });
    Stream<NextScreen> onTap = input.onTap.map((event) {
      if (event == ScreenType.ContactInfo) {
        return NextScreen(event, null);
      }
      return NextScreen(event, null);
    });

    output = YourProfileViewModelOutput(onContactInfo, onTap);
  }

  Stream<ContactInfo> _getUserProfile() {
    return _userProfileRepo.fetchContactInfo();
  }
}

class YourProfileViewModelInput {
  final Subject<bool> onStart;
  final Subject<ScreenType> onTap;

  YourProfileViewModelInput(
    this.onStart,
    this.onTap,
  );
}

class YourProfileViewModelOutput {
  final Stream<ContactInfo> contactInfo;
  final Stream<NextScreen> onNextScreen;

  YourProfileViewModelOutput(
    this.contactInfo,
    this.onNextScreen,
  );
}
