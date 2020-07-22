import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/util/validator.dart';

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

class ContactInfoViewModel {
  ContactInfo contactInfo = ContactInfo();
  final UserProfileRepo _userProfileRepo;

  StreamController<Error> _errorController = StreamController<Error>();

  ContactInfoViewModel(this._userProfileRepo);

  Stream<Error> get error => _errorController.stream;

  onValueChanged(String value, FieldType fieldType) {
    String error = AppTextValidator().validate(value, fieldType);
    _errorController.add(Error(error, fieldType));
    if (error == null) {
      saveFieldInfo(value, fieldType);
    }
  }

  onApply() {
    _userProfileRepo.saveContactInfo(contactInfo);
  }

  void saveFieldInfo(String value, FieldType fieldType) {
    switch (fieldType) {
      case FieldType.firstNameField:
        contactInfo.firstName = value;
        break;
      case FieldType.lastNameField:
        contactInfo.lastName = value;
        break;
      case FieldType.emailAddressField:
        contactInfo.emailAddress = value;
        break;
      case FieldType.phoneNumberField:
        contactInfo.phoneNumber = value;
        break;
      case FieldType.streetAddressField:
        contactInfo.streetAddress = value;
        break;
      case FieldType.cityField:
        contactInfo.city = value;
        break;
      case FieldType.countryField:
        contactInfo.country = value;
        break;
      case FieldType.zipCodeField:
        contactInfo.zipCode = value;
        break;
    }
  }
}

class Error {
  final String error;
  final FieldType fieldType;

  Error(this.error, this.fieldType);
}
