import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInputFieldWidget extends StatelessWidget {
  final String label;
  final String error;
  final TextInputType textInputType;
  final String value;
  final VoidCallback onValueChanged;

  const AppInputFieldWidget({
    Key key,
    this.label,
    this.error,
    this.value,
    this.onValueChanged,
    this.textInputType,
  }) : super(key: key);

  factory AppInputFieldWidget.fromModel(AppInputFieldModel model) {
    return AppInputFieldWidget(
        label: model.label,
        error: model.error,
        textInputType: model.textInputType,
        value: model.value,
        onValueChanged: () => model.onAppInputFieldChanged(model));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
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
      onChanged: (string) => onValueChanged,
    );
  }
}
