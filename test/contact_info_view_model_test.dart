import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/location_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/location_repo.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:albums/ui/contact_info/validator.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockUserProfileRepo extends Mock implements UserProfileRepo {}

class MockLocationRepo extends Mock implements LocationRepo {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockUserProfileRepo = MockUserProfileRepo();
  final mockLocationRepo = MockLocationRepo();
  final Subject<bool> onStart = PublishSubject();
  final Subject<bool> onApply = PublishSubject();
  final Subject<bool> onLocationButtonPressed = PublishSubject();
  final Subject<AppInputFieldModel> onValueChanged = PublishSubject();
  final ContactInfoViewModelInput input = ContactInfoViewModelInput(
    onStart,
    onApply,
    onValueChanged,
    onLocationButtonPressed,
  );
  final AppTextValidator validator = AppTextValidator();
  final ContactInfoViewModel viewModel = ContactInfoViewModel(
      input, mockUserProfileRepo, validator, mockLocationRepo);
  String firstName = 'test';
  String lastName = 'lastName';
  String email = 'test@test.com';
  String phoneNumber = '123456';

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

  List<AppInputFieldModel> modelList = [];

  AppInputFieldModel model1 = AppInputFieldModel(
    fieldType: FieldType.firstNameField,
    value: firstName,
    error: null,
  );
  modelList.add(model1);
  AppInputFieldModel model2 = AppInputFieldModel(
    fieldType: FieldType.lastNameField,
    value: lastName,
    error: null,
  );
  modelList.add(model2);
  AppInputFieldModel model3 = AppInputFieldModel(
    fieldType: FieldType.emailAddressField,
    value: email,
    error: null,
  );
  modelList.add(model3);
  AppInputFieldModel model4 = AppInputFieldModel(
    fieldType: FieldType.phoneNumberField,
    value: phoneNumber,
    error: null,
  );
  modelList.add(model4);
  AppInputFieldModel model5 = AppInputFieldModel(
    fieldType: FieldType.streetAddressField,
    value: locationInfo.streetAddress,
    error: null,
  );
  modelList.add(model5);
  AppInputFieldModel model6 = AppInputFieldModel(
    fieldType: FieldType.cityField,
    value: locationInfo.city,
    error: null,
  );
  modelList.add(model6);
  AppInputFieldModel model7 = AppInputFieldModel(
    fieldType: FieldType.countryField,
    value: locationInfo.country,
    error: null,
  );
  modelList.add(model7);
  AppInputFieldModel model8 = AppInputFieldModel(
    fieldType: FieldType.zipCodeField,
    value: locationInfo.zipCode,
    error: null,
  );
  modelList.add(model8);

  test('test viewmodel init fields correctly', () {
    when(mockUserProfileRepo.fetchContactInfo())
        .thenAnswer((_) => Stream.value(Result.success(contactInfo)));
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
  });

  test(
      'test viewmodel onValueChanged => error is null after calling onValueChanged',
      () {
    AppInputFieldModel testModel = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: firstName,
      error: "test",
    );

    AppInputFieldModel expectedTestModel = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: firstName,
      error: null,
    );

    modelList.replaceRange(0, 1, [expectedTestModel]);
    when(mockUserProfileRepo.fetchContactInfo())
        .thenAnswer((_) => Stream.value(Result.success(contactInfo)));

    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onValueChanged.add(testModel);
    viewModel.input.onStart.add(true);
  });

  test('apply changed value', () {
    AppInputFieldModel model1 = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: "name2",
      error: null,
    );

    ContactInfo newContactInfo = ContactInfo(
      firstName: "name2",
      lastName: lastName,
      emailAddress: email,
      phoneNumber: phoneNumber,
      locationInfo: locationInfo,
    );

    modelList.replaceRange(0, 1, [model1]);
    when(mockUserProfileRepo.fetchContactInfo())
        .thenAnswer((_) => Stream.value(Result.success(newContactInfo)));
    when(mockUserProfileRepo.saveContactInfo(contactInfo))
        .thenAnswer((_) => Stream.value(Result.success(true)));

    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onValueChanged.add(model1);
    viewModel.input.onApply.add(true);
    viewModel.input.onStart.add(true);
  });

  test('test viewmodel onLocationButtonPressed', () {
    AppCoordinates testCoordinates = AppCoordinates(
      latitude: 46.77,
      longitude: 23.58,
    );
    AppAddress testAddress = AppAddress(
      coordinates: testCoordinates,
      thoroughfare: "Test",
      featureName: "234",
      countryName: "Test",
      cityName: "Test",
      postalCode: "123",
    );

    AppInputFieldModel street = AppInputFieldModel(
      fieldType: FieldType.streetAddressField,
      value: '${testAddress.featureName} ${testAddress.thoroughfare} ',
      error: null,
    );

    AppInputFieldModel city = AppInputFieldModel(
      fieldType: FieldType.cityField,
      value: testAddress.cityName,
      error: null,
    );

    AppInputFieldModel country = AppInputFieldModel(
      fieldType: FieldType.countryField,
      value: testAddress.countryName,
      error: null,
    );

    AppInputFieldModel zipcode = AppInputFieldModel(
      fieldType: FieldType.zipCodeField,
      value: testAddress.postalCode,
      error: null,
    );

    when(mockLocationRepo.getCurrentLocation()).thenAnswer(
        (_) => Stream.value(Result<AppCoordinates>.success(testCoordinates)));
    when(mockLocationRepo.decodeUserLocation(testCoordinates)).thenAnswer(
        (_) => Stream.value(Result<AppAddress>.success(testAddress)));
    when(mockUserProfileRepo.fetchContactInfo())
        .thenAnswer((_) => Stream.value(Result.success(contactInfo)));

    modelList.replaceRange(4, 8, [street, city, country, zipcode]);

    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onLocationButtonPressed.add(true);
    viewModel.input.onStart.add(true);
  });
}
