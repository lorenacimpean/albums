import 'package:flutter/cupertino.dart';

class ErrorTextWidget extends StatelessWidget {
  final String error;

  @override
  Widget build(BuildContext context) {
    return Text(error);
  }

  ErrorTextWidget(this.error);
}
