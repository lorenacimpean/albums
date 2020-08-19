import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/deeplink_repo.dart';
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
    Stream<NextScreen> onNextScreen = MergeStream([
      input.onTap.map((event) {
        return event;
      }),
      input.onDeepLinkResult.map((deepLinkResult) {
        return NextScreen.fromDeepLinkResult(deepLinkResult);
      }),
    ]);

    output = YourProfileViewModelOutput(
      onContactInfo,
      onNextScreen,
    );
  }

  Stream<ContactInfo> _getUserProfile() {
    return _userProfileRepo.fetchContactInfo();
  }
}

class YourProfileViewModelInput {
  final Subject<DeepLinkResult> onDeepLinkResult;
  final Subject<bool> onStart;
  final Subject<NextScreen> onTap;

  YourProfileViewModelInput(
    this.onStart,
    this.onTap,
    this.onDeepLinkResult,
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
