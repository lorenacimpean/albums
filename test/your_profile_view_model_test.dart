import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/location_info.dart';
import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:albums/ui/profile/your_profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockUserProfileRepo extends Mock implements UserProfileRepo {}

void main() {
  final mockUserProfileRepo = MockUserProfileRepo();
  final YourProfileViewModel _viewModel = YourProfileViewModel(
    mockUserProfileRepo,
    YourProfileViewModelInput(
      PublishSubject(),
      PublishSubject(),
      PublishSubject(),
    ),
  );

  test('test onStart => contact info', () {
    String firstName = 'initial';
    String lastName = 'lastName';
    String email = 'test@test.com';
    String phoneNumber = '123456789';

    LocationInfo locationInfo = LocationInfo(
      streetAddress: "street",
      city: "city",
      country: "country",
      zipCode: "1234",
    );

    ContactInfo contactInfo = ContactInfo(
      firstName: firstName,
      lastName: lastName,
      emailAddress: email,
      phoneNumber: phoneNumber,
      locationInfo: locationInfo,
    );

    when(mockUserProfileRepo.fetchContactInfo()).thenAnswer((_) {
      return Stream.value(contactInfo);
    });

    expect(_viewModel.output.contactInfo, emits(contactInfo));
    _viewModel.input.onStart.add(true);
  });

  test('test onStart => null', () {
    when(mockUserProfileRepo.fetchContactInfo()).thenAnswer((_) {
      return Stream.value(null);
    });

    expect(_viewModel.output.contactInfo, emits(null));
    _viewModel.input.onStart.add(true);
  });

  test('test onTap => NextScreen', () {
    NextScreen nextScreen = NextScreen(ScreenType.Notifications, null);

    expect(_viewModel.output.onNextScreen, emits(nextScreen));
    _viewModel.input.onTap.add(nextScreen);
  });

  test('test onDeepLinkResult => NextScreen', () {
    DeepLinkResult deepLinkResult =
        DeepLinkResult(DeepLinkAction.openNotifications);
    NextScreen nextScreen = NextScreen.fromDeepLinkResult(deepLinkResult);

    expect(_viewModel.output.onNextScreen, emits(nextScreen));
    _viewModel.input.onDeepLinkResult.add(deepLinkResult);
  });
}
