import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum KeyboardType { textKeyboard, numberKeyboard, emailKeyboard }

class AppInputFieldWidget extends StatelessWidget {
  final String label;
  final String error;
  final KeyboardType keyboardType;
  final ValueChanged<String> onValueChanged;

  const AppInputFieldWidget(
      {Key key, this.label, this.keyboardType, this.onValueChanged, this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).accentTextTheme.subtitle2,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).accentTextTheme.subtitle2,
      ),
      keyboardType: getKeyboardType(keyboardType),
      validator: (value) {
        return error;
      },
      onChanged: onValueChanged,
    );
  }

  TextInputType getKeyboardType(keyboardType) {
    switch (keyboardType) {
      case KeyboardType.emailKeyboard:
        return TextInputType.emailAddress;
      case KeyboardType.numberKeyboard:
        return TextInputType.number;
      case KeyboardType.textKeyboard:
      default:
        return TextInputType.text;
    }
  }
}
