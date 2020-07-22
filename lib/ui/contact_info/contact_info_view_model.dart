import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

enum FieldType {
  firstNameField,
  lastNameField,
  emailAddressField,
  phoneNumberField,
  streetAddressField,
  cityField,
  countryField,
  zipCodeField
}
enum KeyboardType { text, number, email }

typedef void OnAppInputFieldChanged(AppInputFieldModel model);

class AppInputFieldModel {
  String error;
  final FieldType fieldType;
  String value;
  OnAppInputFieldChanged onAppInputFieldChanged;

  String get label {
    switch (fieldType) {
      case FieldType.firstNameField:
        return AppStrings.firstName;
        break;
      case FieldType.lastNameField:
        return AppStrings.lastName;
        break;
      case FieldType.emailAddressField:
        return AppStrings.emailAddress;
        break;
      case FieldType.phoneNumberField:
        return AppStrings.phoneNumber;
        break;
      case FieldType.streetAddressField:
        return AppStrings.streetAddress;
        break;
      case FieldType.cityField:
        return AppStrings.city;
        break;
      case FieldType.countryField:
        return AppStrings.country;
        break;
      case FieldType.zipCodeField:
        return AppStrings.zipCode;
        break;
      default:
        return null;
    }
  }

  TextInputType get textInputType {
    switch (fieldType) {
      case FieldType.firstNameField:
      case FieldType.lastNameField:
      case FieldType.streetAddressField:
      case FieldType.countryField:
      case FieldType.cityField:
        return TextInputType.text;
        break;
      case FieldType.emailAddressField:
        return TextInputType.emailAddress;
        break;
      case FieldType.phoneNumberField:
      case FieldType.zipCodeField:
        return TextInputType.number;
        break;
      default:
        return null;
    }
  }

  AppInputFieldModel(
      {this.error, this.value, this.fieldType, this.onAppInputFieldChanged});
}

class ContactInfoViewModel {
  final ContactInfoViewModelInput input;
  final UserProfileRepo _userProfileRepo;
  final AppTextValidator _validator;
  ContactInfoViewModelOutput output;
  List<AppInputFieldModel> _list = List<AppInputFieldModel>();

  ContactInfoViewModel(this.input, this._userProfileRepo, this._validator) {
    initFields(_list);
    var onList = MergeStream([
      input.onStart.map((event) => _list),
      input.onValueChanged.map((inputField) {
        _list.removeWhere(
            (element) => element.fieldType == inputField.fieldType);
        _list.add(inputField..error = null);
        return _list;
      }),
      input.onApply.flatMap((event) {
        _list
            .map((field) => field..error = _validator.validate(field))
            .toList();
        bool isValid = _list.firstWhere((element) => element.error != null,
                orElse: () => null) ==
            null;
        if (isValid) {
          return _userProfileRepo
              .saveContactInfo(ContactInfo.fromJson({}))
              .asStream()
              .map((event) => _list);
        } else {
          return Stream.value(_list);
        }
      })
    ]);
    output = ContactInfoViewModelOutput(onList);
  }

  initFields(List<AppInputFieldModel> list) {
    FieldType.values.forEach((element) {
      _list.add(AppInputFieldModel(
          fieldType: element,
          error: null,
          value: null,
          onAppInputFieldChanged: null));
    });
  }
}

class ContactInfoViewModelInput {
  final Subject<bool> onStart;
  final Subject<bool> onApply;
  final Subject<AppInputFieldModel> onValueChanged;
  ContactInfoViewModelInput(this.onStart, this.onApply, this.onValueChanged);
}

class ContactInfoViewModelOutput {
  final Stream<List<AppInputFieldModel>> fieldList;
  ContactInfoViewModelOutput(this.fieldList);
}
