import 'package:albums/data/model/contact_info.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/ui/home_screen/app_tab_model.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';

void main() {
  test('tab not selected test ', () {
    AppTab mockTab =
        AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false);
    List<AppTab> tabList = List<AppTab>();
    tabList.add(mockTab);

    AppTab selectedTab = tabList.getSelectedTab();
    expect(selectedTab, null);
  });

  test('tab selected test ', () {
    AppTab mockTab =
        AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, true);
    List<AppTab> tabList = List<AppTab>();
    tabList.add(mockTab);

    AppTab selectedTab = tabList.getSelectedTab();
    expect(selectedTab, mockTab);
  });

  test('selected tab index', () {
    AppTab mockTab =
        AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, true);
    List<AppTab> tabList = List<AppTab>();
    tabList.add(mockTab);

    int index = tabList.getSelectedIndex();
    expect(index, 0);
  });

  test('compare lists false', () {
    List<AppTab> listA = List<AppTab>();
    listA.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, true));
    List<AppTab> listB = List<AppTab>();
    listB.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false));

    expect(listA.compare(listB), false);
  });

  test('compare lists true', () {
    List<AppTab> listA = List<AppTab>();
    listA.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false));
    List<AppTab> listB = List<AppTab>();
    listB.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false));

    expect(listA.compare(listB), true);
  });
  test('getModelFromFieldType', () {
    List<AppInputFieldModel> modelList = [];
    AppInputFieldModel model = AppInputFieldModel(
        fieldType: FieldType.firstNameField,
        textController: TextEditingController(),
        error: 'error',
        value: 'value');
    modelList.add(model);
    expect(modelList.getModelFromFieldType(FieldType.firstNameField), model);
  });
  test('areAllFieldsValid, true', () {
    List<AppInputFieldModel> modelList = [];
    AppInputFieldModel model1 =
        AppInputFieldModel(fieldType: FieldType.firstNameField, value: 'value');
    modelList.add(model1);
    AppInputFieldModel model2 = AppInputFieldModel(
        fieldType: FieldType.emailAddressField, value: 'test@test.com');
    modelList.add(model2);
    expect(modelList.areAllFieldsValid(), true);
  });
  test('areAllFields valid, false', () {
    List<AppInputFieldModel> modelList = [];
    AppInputFieldModel model1 =
        AppInputFieldModel(fieldType: FieldType.firstNameField, value: 'value');
    modelList.add(model1);
    AppInputFieldModel model2 = AppInputFieldModel(
        fieldType: FieldType.emailAddressField, error: 'error');
    modelList.add(model2);
    expect(modelList.areAllFieldsValid(), false);
  });

  test('valueForFieldType', () {
    List<AppInputFieldModel> modelList = [];
    AppInputFieldModel model1 =
        AppInputFieldModel(fieldType: FieldType.firstNameField, value: '1234');
    modelList.add(model1);
    FieldType fieldType = FieldType.firstNameField;
    expect(modelList.valueForFieldType(fieldType), '1234');
  });
  test('toContactInfo', () {
    String firstName = 'test';
    String lastName = 'lastName';
    String email = 'test@test.com';
    String phoneNumber = '123456';
    ContactInfo contactInfo = ContactInfo(
        firstName: firstName,
        lastName: lastName,
        emailAddress: email,
        phoneNumber: phoneNumber);

    List<AppInputFieldModel> modelList = [];
    AppInputFieldModel model1 = AppInputFieldModel(
        fieldType: FieldType.firstNameField, value: firstName);
    modelList.add(model1);
    AppInputFieldModel model2 =
        AppInputFieldModel(fieldType: FieldType.lastNameField, value: lastName);
    modelList.add(model2);
    AppInputFieldModel model3 = AppInputFieldModel(
        fieldType: FieldType.emailAddressField, value: email);
    modelList.add(model3);
    AppInputFieldModel model4 = AppInputFieldModel(
        fieldType: FieldType.phoneNumberField, value: phoneNumber);
    modelList.add(model4);

    expect(modelList.toContactInfo().firstName, contactInfo.firstName);
    expect(modelList.toContactInfo().lastName, contactInfo.lastName);
    expect(modelList.toContactInfo().emailAddress, contactInfo.emailAddress);
    expect(modelList.toContactInfo().phoneNumber, contactInfo.phoneNumber);
  });
}
