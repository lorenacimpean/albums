import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInputFieldWidget extends StatefulWidget {
  final String label;
  final Error error;
  final FieldType fieldType;
  final ValueChanged<String> onValueChanged;

  const AppInputFieldWidget({
    Key key,
    this.label,
    this.onValueChanged,
    this.error,
    this.fieldType,
  }) : super(key: key);

  @override
  _AppInputFieldWidgetState createState() => _AppInputFieldWidgetState();
}

class _AppInputFieldWidgetState extends State<AppInputFieldWidget> {
  String error;

  @override
  Widget build(BuildContext context) {
    if (widget.error?.fieldType == widget.fieldType) {
      error = widget.error?.error;
    }
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        errorText: error,
        errorMaxLines: 2,
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.subtitle1,
      ),
      keyboardType: textInput(widget.fieldType),
      onChanged: (string) => widget.onValueChanged(string),
    );
  }

  TextInputType textInput(FieldType fieldType) {
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
