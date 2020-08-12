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
    Result<List<AppInputFieldModel>> expectedResult = Result.success(modelList);
    when(mockUserProfileRepo.fetchContactInfo()).thenAnswer(
      (_) => Stream.value(
        contactInfo,
      ),
    );
    expect(
      viewModel.output.fieldList,
      emitsInOrder([
        Result<List<AppInputFieldModel>>.loading(null),
        expectedResult,
      ]),
    );
    viewModel.input.onStart.add(true);
  });

  test(
      'test viewmodel onValueChanged => error is null after calling onValueChanged',
      () {
    AppInputFieldModel firstNameWithError = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: 'test error is null',
      error: 'error',
    );
    AppInputFieldModel firstNameNoError = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: 'test error is null',
      error: null,
    );
    ContactInfo newContactInfo = ContactInfo(
      firstName: 'test error is null',
      lastName: lastName,
      emailAddress: email,
      phoneNumber: phoneNumber,
      locationInfo: locationInfo,
    );

    List<AppInputFieldModel> updatedList = [];
    updatedList.addAll(modelList);
    updatedList.replaceRange(0, 1, [firstNameNoError]);
    Result<List<AppInputFieldModel>> expectedResult1 =
        Result.success(modelList);
    Result<List<AppInputFieldModel>> expectedResult2 =
        Result.success(updatedList);

    when(mockUserProfileRepo.fetchContactInfo()).thenAnswer((_) {
      return Stream.value(contactInfo);
    });
    when(mockUserProfileRepo.saveContactInfo(newContactInfo)).thenAnswer((_) {
      return Stream.value(true);
    });

    expect(
        viewModel.output.fieldList,
        emitsInOrder([
          Result<List<AppInputFieldModel>>.loading(null),
          expectedResult1,
          expectedResult2,
        ]));
    viewModel.input.onStart.add(true);
    Stream.value(true).delay(Duration(milliseconds: 100)).listen((event) {
      viewModel.input.onValueChanged.add(firstNameWithError);
    });
  });

  test('test errors onApply', () {
    List<AppInputFieldModel> listWithError = [];
    List<AppInputFieldModel> listWithNoError = [];

    AppInputFieldModel firstNameWithError = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: '',
      error: 'Required',
    );
    AppInputFieldModel firstNameNoError = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: '',
    );
    ContactInfo newContactInfo = ContactInfo(
      firstName: '',
      lastName: lastName,
      emailAddress: email,
      phoneNumber: phoneNumber,
      locationInfo: locationInfo,
    );

    listWithError.addAll(modelList);
    listWithError.replaceRange(0, 1, [firstNameWithError]);
    listWithNoError.addAll(modelList);
    listWithNoError.replaceRange(0, 1, [firstNameNoError]);
    Result<List<AppInputFieldModel>> expectedResult1 =
        Result.success(listWithNoError);
    Result<List<AppInputFieldModel>> expectedResult2 =
        Result.success(listWithError);

    when(mockUserProfileRepo.fetchContactInfo()).thenAnswer((_) {
      return Stream.value(newContactInfo);
    });
    when(mockUserProfileRepo.saveContactInfo(newContactInfo)).thenAnswer((_) {
      return Stream.value(true);
    });

    expect(
        viewModel.output.fieldList,
        emitsInOrder([
          Result<List<AppInputFieldModel>>.loading(null),
          expectedResult1,
          expectedResult2,
        ]));

    viewModel.input.onStart.add(true);
    Stream.value(false).delay(Duration(milliseconds: 100)).listen((event) {
      viewModel.input.onApply.add(true);
    });
  });

  test('apply changed value - no errors', () {
    AppInputFieldModel updatedModel = AppInputFieldModel(
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
    List<AppInputFieldModel> updatedList = [];
    updatedList.addAll(modelList);
    updatedList.replaceRange(0, 1, [updatedModel]);
    Result<List<AppInputFieldModel>> expectedResult1 =
        Result.success(modelList);
    Result<List<AppInputFieldModel>> expectedResult2 =
        Result.success(updatedList);

    when(mockUserProfileRepo.fetchContactInfo())
        .thenAnswer((_) => Stream.value(contactInfo));
    when(mockUserProfileRepo.saveContactInfo(newContactInfo))
        .thenAnswer((_) => Stream.value(true));

    expect(
        viewModel.output.fieldList,
        emitsInOrder([
          Result<List<AppInputFieldModel>>.loading(null),
          expectedResult1,
          expectedResult2,
          expectedResult2,
        ]));

    viewModel.input.onStart.add(true);
    Stream.value(true).delay(Duration(milliseconds: 200)).listen((event) {
      viewModel.input.onValueChanged.add(updatedModel);
    });
    Stream.value(true).delay(Duration(milliseconds: 300)).listen((event) {
      viewModel.input.onApply.add(true);
    });
  });

//  test('test viewmodel onLocationButtonPressed', () {
//    AppCoordinates testCoordinates = AppCoordinates(
//      latitude: 46.77,
//      longitude: 23.58,
//    );
//    AppAddress testAddress = AppAddress(
//      coordinates: testCoordinates,
//      thoroughfare: "Test",
//      featureName: "234",
//      countryName: "Test",
//      cityName: "Test",
//      postalCode: "123",
//    );
//
//    AppInputFieldModel street = AppInputFieldModel(
//      fieldType: FieldType.streetAddressField,
//      value: '${testAddress.featureName} ${testAddress.thoroughfare} ',
//      error: null,
//    );
//
//    AppInputFieldModel city = AppInputFieldModel(
//      fieldType: FieldType.cityField,
//      value: testAddress.cityName,
//      error: null,
//    );
//
//    AppInputFieldModel country = AppInputFieldModel(
//      fieldType: FieldType.countryField,
//      value: testAddress.countryName,
//      error: null,
//    );
//
//    AppInputFieldModel zipcode = AppInputFieldModel(
//      fieldType: FieldType.zipCodeField,
//      value: testAddress.postalCode,
//      error: null,
//    );
//
//    List<AppInputFieldModel> updatedList = [];
//    updatedList.addAll(modelList);
//    updatedList.replaceRange(4, 8, [street, city, country, zipcode]);
//
//    when(mockLocationRepo.getCurrentLocation()).thenAnswer(
//      (_) => Stream.value(
//        Result<AppCoordinates>.success(testCoordinates),
//      ),
//    );
//    when(mockLocationRepo.decodeUserLocation(testCoordinates)).thenAnswer(
//      (_) => Stream.value(
//        Result<AppAddress>.success(testAddress),
//      ),
//    );
//    when(mockUserProfileRepo.fetchContactInfo()).thenAnswer(
//      (_) => Stream.value(
//        Result<ContactInfo>.success(contactInfo),
//      ),
//    );
//    Result<List<AppInputFieldModel>> expectedResult1 =
//        Result.success(modelList);
//    Result<List<AppInputFieldModel>> expectedResult2 =
//        Result.success(updatedList);
//
//    expect(
//        viewModel.output.fieldList,
//        emitsInOrder([
//          Result<List<AppInputFieldModel>>.loading(null),
//          expectedResult1,
//          expectedResult2,
//        ]));
//    viewModel.input.onStart.add(true);
//    Stream.value(true).delay(Duration(milliseconds: 200)).listen((event) {
//      viewModel.input.onLocationButtonPressed.add(true);
//    });
//  });
}
