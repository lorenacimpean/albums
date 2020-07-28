import 'package:albums/themes/strings.dart';
import 'package:albums/ui/contact_info/validator.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:test/test.dart';

void main() {
  AppTextValidator validator = AppTextValidator();
  test('test text validator', () {
    String text = "validText";
    String invalidText = "qw";

    expect(validator.textValidator(text), null);
    expect(validator.textValidator(invalidText), AppStrings.fieldInvalidError);
    expect(validator.textValidator(""), AppStrings.fieldEmptyError);
  });

  test('test phone validator', () {
    String validPhone = "123456789";
    String invalidPhone = "12";
    expect(validator.phoneValidator(validPhone), null);
    expect(validator.phoneValidator(invalidPhone),
        AppStrings.phoneFieldInvalidError);
    expect(validator.phoneValidator(""), AppStrings.fieldEmptyError);
  });

  test('test email validator', () {
    String validEmail = "test@test.com";
    String invalidEmail = "test";
    expect(validator.emailValidator(validEmail), null);
    expect(validator.emailValidator(invalidEmail),
        AppStrings.emailFieldInvalidError);
    expect(validator.emailValidator(""), AppStrings.fieldEmptyError);
  });

  test('test validate model', () {
    String text = "validText";
    String invalidText = "qw";
    AppInputFieldModel model1 =
        AppInputFieldModel(fieldType: FieldType.firstNameField, value: text);
    AppInputFieldModel model2 = AppInputFieldModel(
        fieldType: FieldType.firstNameField, value: invalidText);
    AppInputFieldModel model3 =
        AppInputFieldModel(fieldType: FieldType.firstNameField, value: "");
    String actualResult1 = validator.validate(model1);
    String actualResult2 = validator.validate(model2);
    String actualResult3 = validator.validate(model3);
    expect(actualResult1, null);
    expect(actualResult2, AppStrings.fieldInvalidError);
    expect(actualResult3, AppStrings.fieldEmptyError);
  });
}
