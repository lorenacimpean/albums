import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/location_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/location_repo.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:albums/ui/contact_info/validator.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class MockUserProfileRepo extends Mock implements UserProfileRepo {}

main() {
  final mockUserProfileRepo = MockUserProfileRepo();
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
  final LocationRepo locationRepo = LocationRepo();
  final viewModel =
      ContactInfoViewModel(input, mockUserProfileRepo, validator, locationRepo);
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

  when(mockUserProfileRepo.fetchContactInfo())
      .thenAnswer((_) => Stream.value(Result.success(contactInfo)));
  when(mockUserProfileRepo.saveContactInfo(contactInfo))
      .thenAnswer((_) => Stream.value(Result.success(true)));

  test('test viewmodel start true', () async {
    expect(viewModel.input, isNotNull);
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
  });

  test('test viewmodel start false', () async {
    expect(viewModel.input, isNotNull);
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
  });

  test('test viewmodel onApply', () async {
    expect(viewModel.input, isNotNull);
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
  });

  test('test viewmodel onValueChanged', () async {
    AppInputFieldModel testModel = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: firstName,
      error: "test",
    );
    expect(viewModel.input, isNotNull);
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
    viewModel.input.onValueChanged.add(testModel);
  });

  test('apply changed value', () async{
    AppInputFieldModel model1 = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: "name2",
      error: "test",
    );
    expect(viewModel.input, isNotNull);
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
    viewModel.input.onValueChanged.add(model1);
    viewModel.input.onApply.add(true);
  });

  test('test prefilled values', () async{
    AppInputFieldModel model1 = AppInputFieldModel(
      fieldType: FieldType.firstNameField,
      value: "name2",
      error: "test",
    );
    expect(viewModel.input, isNotNull);
    expect(viewModel.output, isNotNull);
    expect(viewModel.output.fieldList, emits(modelList));
    viewModel.input.onStart.add(true);
    viewModel.input.onValueChanged.add(model1);
    viewModel.input.onApply.add(true);
  });
}
