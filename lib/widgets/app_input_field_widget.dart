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
  final TextEditingController controller;
  final String label;
  final String error;
  final ValueChanged<String> onValueChanged;

  AppInputFieldWidget({
    Key key,
    this.controller,
    this.textInputType,
    this.label,
    this.error,
    this.onValueChanged,
  }) : super(key: key);

  factory AppInputFieldWidget.fromModel({AppInputFieldModel model}) {
    return AppInputFieldWidget(
      textInputType: model.textInputType,
      controller: model.textController,
      label: model.label,
      error: model.error,
      onValueChanged: (newValue) {
        model.value = newValue;
        model.onValueChanged(model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: error == null
          ? Theme.of(context).textTheme.subtitle2
          : Theme.of(context).textTheme.button,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: error == null
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).errorColor,
                width: 2)),
        labelText: label,
        labelStyle: error == null
            ? Theme.of(context).textTheme.subtitle1
            : Theme.of(context).textTheme.button,
      ),
      keyboardType: textInputType,
      onChanged: onValueChanged,
    );
  }
}

class AppInputFieldModel {
  final FieldType fieldType;
  final TextEditingController textController;
  String error;
  String value;
  OnAppInputFieldChange onValueChanged;

  AppInputFieldModel(
      {this.fieldType,
      this.textController,
      this.error,
      this.value,
      this.onValueChanged});

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
