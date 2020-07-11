import 'package:flutter/cupertino.dart';

class ErrorTextWidget extends StatelessWidget {
  final String error;

  const ErrorTextWidget({
    Key key,
    @required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(error);
  }
}
//add global key as optional param
