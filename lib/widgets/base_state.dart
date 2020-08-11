import 'dart:async';
import 'dart:io';

import 'package:albums/data/model/result.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_center_continer_widget.dart';
import 'package:albums/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  List<StreamSubscription> _subscriptions = List();

  void disposeLater(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  void handleError({Object error, VoidCallback retry}) {
    if (error is SocketException) {
      handleNoInternetConnection(retry: retry);
    }
    if (error is ErrorState) {
      handleStringError(errorText: error.msg);
    }
  }

  void handleStringError({String errorText}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppCenterContainerWidget(
            textColor: AppColors.red,
            borderColor: AppColors.red,
            text: errorText = null ? AppStrings.errorWhileLoading : errorText,
          );
        });
  }

  void handleNoInternetConnection({VoidCallback retry}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return NoInternetConnectionWidget(
            retry: retry,
          );
        });
  }

  @override
  void dispose() {
    _subscriptions?.forEach((element) {
      element?.cancel();
    });
    _subscriptions?.clear();
    super.dispose();
  }
}
