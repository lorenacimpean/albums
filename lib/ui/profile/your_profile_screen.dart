import 'dart:async';

import 'package:albums/themes/icons.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/profile/your_profile_view_model.dart';
import 'package:albums/util/next_screen.dart';
import 'package:albums/widgets/app_bar_widget.dart';
import 'package:albums/widgets/app_header_info_widget.dart';
import 'package:albums/widgets/app_list_tile_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:flutter/cupertino.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({Key key}) : super(key: key);

  @override
  _YourProfileScreenState createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  YourProfileViewModel _viewModel;
  StreamSubscription _nextScreenSubscription;

  void initState() {
    super.initState();
    _viewModel = YourProfileViewModel();
    _nextScreenSubscription = _viewModel.nextScreenStream.listen((nextScreen) {
      route(context, nextScreen);
    });
  }

  void dispose() {
    _nextScreenSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.profileTitle,
      buttonType: ButtonType.iconButton,
      onRightButtonTap: () {
        _viewModel.onNotificationIconTapped();
      },
      key: Key(AppStrings.profileTitle),
      body: Column(
        children: <Widget>[
          AppHeaderInfo(),
          AppListTile(
            title: AppStrings.contactInfo,
            icon: AppIcons.contactInfoIcon,
            onTap: () {
              _viewModel.onContactInfoTapped();
            },
          ),
        ],
      ),
    );
  }
}
