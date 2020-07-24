import 'package:albums/data/model/contact_info.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:albums/widgets/app_input_field_widget.dart';

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
}

extension FieldValidator on List<AppInputFieldModel> {
  bool areAllFieldsValid() {
    return this.firstWhere(
            (field) => field.error != null || field.value == null,
            orElse: () => null) ==
        null;
  }
}

extension FieldValueForType on List<AppInputFieldModel> {
  String valueForFieldType(FieldType fieldType) {
    return this.getModelFromFieldType(fieldType).value;
  }
}

extension ToContactInfo on List<AppInputFieldModel> {
  ContactInfo toContactInfo() {
    return ContactInfo(
      firstName: this.valueForFieldType(FieldType.firstNameField),
      lastName: this.valueForFieldType(FieldType.lastNameField),
      emailAddress: this.valueForFieldType(FieldType.emailAddressField),
      phoneNumber: this.valueForFieldType(FieldType.phoneNumberField),
      streetAddress: this.valueForFieldType(FieldType.streetAddressField),
      city: this.valueForFieldType(FieldType.cityField),
      country: this.valueForFieldType(FieldType.countryField),
      zipCode: this.valueForFieldType(FieldType.zipCodeField),
    );
  }
}
