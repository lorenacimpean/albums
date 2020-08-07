import 'dart:io';

import 'package:albums/widgets/base_state.dart';
import 'package:albums/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ErrorHandlingState<T extends StatefulWidget>
    extends BaseState<T> {
  void handleError(Object error, {VoidCallback retry}) {
    if (error is SocketException) {
      handleNoInternetConnection(retry);
    } if(error is String) {
      //TODO display error popup
    }
  }



  void handleNoInternetConnection(VoidCallback retry) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return NoInternetConnectionWidget(
          retry: () => retry,
        );
      }),
    );
  }
}
