import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/coming_soon_widget.dart';
import 'package:flutter/cupertino.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.newsTitle,
      key: Key(AppStrings.newsTitle),
      body: ComingSoonWidget(),
    );
  }
}
