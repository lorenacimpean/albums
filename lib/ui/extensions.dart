import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/location_info.dart';
import 'package:albums/widgets/app_input_field_widget.dart';

import 'home_screen/app_tab_model.dart';

extension ListExtensions<T> on List<T> {
  int get hash => this.fold(
      1, (previousValue, element) => previousValue.hashCode ^ element.hashCode);

  bool compare(List<T> other) {
    if (length != other.length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}

extension SelectedItems on List<AppTab> {
  int getSelectedIndex() {
    AppTab selectedTab = this.getSelectedTab();
    int index = indexOf(selectedTab);
    return index;
  }

  AppTab getSelectedTab() {
    AppTab selectedTab =
        this?.firstWhere((tab) => tab.isSelected, orElse: () => null);
    return selectedTab;
  }
}

extension FirstLetter on String {
  String firstLetterToUpperCase() {
    String text = this?.substring(0, 1)?.toUpperCase();
    return text;
  }
}

extension ModelFromFieldType on List<AppInputFieldModel> {
  AppInputFieldModel getModelFromFieldType(FieldType fieldType) {
    AppInputFieldModel model = this?.firstWhere(
        (model) => model.fieldType == fieldType,
        orElse: () => null);
    return model;
  }

  bool areAllFieldsValid() {
    return this.firstWhere(
            (field) => field.error != null || field.value == null,
            orElse: () => null) ==
        null;
  }

  String valueForFieldType(FieldType fieldType) {
    return this.getModelFromFieldType(fieldType).value;
  }

  ContactInfo toContactInfo() {
    if (this == null) {
      return null;
    }
    return ContactInfo(
      firstName: this.valueForFieldType(FieldType.firstNameField),
      lastName: this.valueForFieldType(FieldType.lastNameField),
      emailAddress: this.valueForFieldType(FieldType.emailAddressField),
      phoneNumber: this.valueForFieldType(FieldType.phoneNumberField),
      locationInfo: this.toLocationInfo(),
    );
  }

  LocationInfo toLocationInfo() {
    if (this == null) {
      return null;
    }
    return LocationInfo(
      streetAddress: this.valueForFieldType(FieldType.streetAddressField),
      city: this.valueForFieldType(FieldType.cityField),
      country: this.valueForFieldType(FieldType.countryField),
      zipCode: this.valueForFieldType(FieldType.zipCodeField),
    );
  }
}

extension ContactInfoFromEnum on FieldType {
  String fromContactInfo(ContactInfo info) {
    switch (this) {
      case FieldType.firstNameField:
        return info?.firstName;
        break;
      case FieldType.lastNameField:
        return info?.lastName;
        break;
      case FieldType.emailAddressField:
        return info?.emailAddress;
        break;
      case FieldType.phoneNumberField:
        return info?.phoneNumber;
        break;
      case FieldType.streetAddressField:
      case FieldType.cityField:
      case FieldType.countryField:
      case FieldType.zipCodeField:
        return info?.locationInfo?.fromLocationInfo(this);
        break;
      default:
        return null;
    }
  }
}
