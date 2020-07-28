import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:albums/ui/profile/your_profile_view_model.dart';
import 'package:albums/widgets/app_bar_icon_widget.dart';
import 'package:albums/widgets/app_header_info_widget.dart';
import 'package:albums/widgets/app_list_tile_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:flutter/widgets.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({Key key}) : super(key: key);

  @override
  _YourProfileScreenState createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  YourProfileViewModel _viewModel;
  StreamSubscription _nextScreenSubscription;
  ContactInfo _contactInfo;

  void initState() {
    super.initState();
    _viewModel = YourProfileViewModel(buildUserProfileRepo());
    _nextScreenSubscription = _viewModel.nextScreenStream.listen((nextScreen) {
      openNextScreen(context, nextScreen);
    });
    _viewModel.userProfile().listen((Result<ContactInfo> value) {
      setState(() {
        _contactInfo = (value as SuccessState<ContactInfo>)?.value;
      });
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
      rightButtons: <Widget>[
        AppBarIconWidget(
            icon: AppIcons.notificationsIcon,
            onPressed: () {
              _viewModel.onNotificationIconTapped();
            }),
      ],
      key: Key(AppStrings.profileTitle),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(AppPaddings.largePadding),
            child: AppHeaderInfo(
              title: _contactInfo != null
                  ? _contactInfo.firstName + _contactInfo.lastName
                  : "",
              subtitle: _contactInfo != null ? _contactInfo.emailAddress : "",
              iconText: _contactInfo != null
                  ? _contactInfo.firstName.firstLetterToUpperCase()
                  : AppStrings.questionMark,
            ),
          ),
          AppListTile(
            title: AppStrings.contactInfo,
            subtitle: _contactInfo != null
                ? '${AppStrings.emailAddress}: ${_contactInfo.emailAddress}'
                : "",
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
