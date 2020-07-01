import 'package:albums/data/model/result.dart';
import 'package:flutter/cupertino.dart';

StatelessWidget errorWidget(
    BuildContext context, AsyncSnapshot<Result> snapshot) {
  String error = (snapshot.data as ErrorState).msg;
  return Container(child: Text(error));
}
