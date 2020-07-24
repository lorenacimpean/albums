import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_input_field_widget.dart';

class AppTextValidator {
  static const int minimumLength = 3;

  String emptyValidator(String value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldEmptyError;
    }
  }

  String textValidator(String value) {
    emptyValidator(value);
    if (value.length < minimumLength) {
      return AppStrings.fieldInvalidError;
    }
    return null;
  }

  String emailValidator(String value) {
    RegExp emailRegex = RegExp(r"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
    emptyValidator(value);
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailFieldInvalidError;
    }
    return null;
  }

  String phoneValidator(String value) {
    RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
    emptyValidator(value);
    if (!phoneRegex.hasMatch(value)) {
      return AppStrings.phoneFieldInvalidError;
    }
    return null;
  }

  String validate(AppInputFieldModel model) {
    switch (model.fieldType) {
      case FieldType.firstNameField:
      case FieldType.lastNameField:
      case FieldType.streetAddressField:
      case FieldType.countryField:
      case FieldType.cityField:
      case FieldType.zipCodeField:
        return textValidator(model.value);
        break;

      case FieldType.emailAddressField:
        return emailValidator(model.value);
        break;
      case FieldType.phoneNumberField:
        return phoneValidator(model.value);
        break;
      default:
        return null;
    }
  }
}
