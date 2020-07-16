import 'package:albums/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  final String title;
  final Widget body;
  final hasBackButton;

  const AppScreen(
      {Key key,
      @required this.title,
      @required this.body,
      this.hasBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(hasBackButton: hasBackButton, title: title),
      body:
          body,
    );
  }
}
