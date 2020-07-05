import 'package:flutter/cupertino.dart';

class ErrorTextWidget extends StatelessWidget {
  final String error;

  ErrorTextWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Text(error);
  }
}
//add global key as optional param