import 'package:albums/widgets/app_input_field_widget.dart';

class AppTextValidator {
  static const int minimumLength = 3;
  final String value;
  final KeyboardType keyboardType;

  AppTextValidator(this.value, this.keyboardType);

  String textValidator() {
    if (value.isEmpty) {
      return "Field cannot be empty!";
    }
    if (value.length < minimumLength) {
      return "Invalid input! The field must contain at least 3 characters";
    }
    return null;
  }

  String emailValidator() {
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

  String phoneValidator() {
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

  String validate() {
    switch (keyboardType) {
      case KeyboardType.textKeyboard:
        return textValidator();
        break;
      case KeyboardType.numberKeyboard:
        return phoneValidator();
        break;
      case KeyboardType.emailKeyboard:
        return emailValidator();
        break;
      default:
        return null;
    }
  }
}
