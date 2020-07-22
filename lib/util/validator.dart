import 'package:albums/ui/contact_info/contact_info_view_model.dart';

class AppTextValidator {
  static const int minimumLength = 3;

  String textValidator(String value) {
    print("text validator: $value");
    if (value.isEmpty) {
      return "Field cannot be empty!";
    }
    if (value.length < minimumLength) {
      return "Invalid input! The field must contain at least 3 characters";
    }
    return null;
  }

  String emailValidator(String value) {
    RegExp emailRegex = RegExp(r"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
    if (value.isEmpty) {
      return "Field cannot be empty!";
    }
    if (!emailRegex.hasMatch(value)) {
      return "Invalid email!";
    }
    ;
    return null;
  }

  String phoneValidator(String value) {
    RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
    if (value.isEmpty) {
      return "Field cannot be empty!";
    }
    if (!phoneRegex.hasMatch(value)) {
      return "Invalid phone number!";
    }
    ;
    return null;
  }

  String validate(String value, FieldType fieldType) {
    switch (fieldType) {
      case FieldType.firstNameField:
      case FieldType.lastNameField:
      case FieldType.streetAddressField:
      case FieldType.countryField:
      case FieldType.cityField:
      case FieldType.zipCodeField:
        return textValidator(value);
        break;

      case FieldType.emailAddressField:
        return emailValidator(value);
        break;
      case FieldType.phoneNumberField:
        return phoneValidator(value);
        break;
      default:
        return null;
    }
  }
}
