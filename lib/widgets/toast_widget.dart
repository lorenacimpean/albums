import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String toastMessage;


  ToastWidget({Key key, @required this.toastMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).primaryColorDark,
      ),
      child: Text(
        toastMessage,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
