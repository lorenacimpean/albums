import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';

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

typedef OnAppInputFieldChange(AppInputFieldModel model);

class AppInputFieldWidget extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller = TextEditingController();
  final String label;
  final String error;

  final OnAppInputFieldChange onValueChanged;

  AppInputFieldWidget({
    Key key,
    String value,
    this.textInputType,
    this.label,
    this.error,
    this.onValueChanged,
  }) : super(key: key) {
    controller.text = value;
  }

  factory AppInputFieldWidget.fromModel({AppInputFieldModel model}) {
    return AppInputFieldWidget(
      label: model.label,
      error: model.error,
      value: model.value,
      textInputType: model.textInputType,
      onValueChanged: model.onValueChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      controller: controller,
      decoration: InputDecoration(
        errorText: error,
        errorMaxLines: 2,
        enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        labelText: label,
        labelStyle: Theme.of(context).textTheme.subtitle1,
      ),
      keyboardType: textInputType,
      onChanged: (model) => onValueChanged,
    );
  }
}

class AppInputFieldModel {
  final FieldType fieldType;
  String error;
  String value;
  OnAppInputFieldChange onValueChanged;

  AppInputFieldModel({
    this.error,
    this.value,
    this.fieldType,
    this.onValueChanged,
  });

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
}

