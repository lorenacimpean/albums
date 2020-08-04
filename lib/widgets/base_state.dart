import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  List<StreamSubscription> _subscriptions = List();

  void disposeLater(StreamSubscription subscription) {
    _subscriptions.add(subscription);
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
