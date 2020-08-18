import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/deeplink_repo.dart';
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
import 'package:albums/widgets/base_state.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class YourProfileScreen extends StatefulWidget {
  final DeepLinkResult deepLinkResult;

  const YourProfileScreen({
    Key key,
    this.deepLinkResult,
  }) : super(key: key);

  @override
  _YourProfileScreenState createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends BaseState<YourProfileScreen> {
  YourProfileViewModel _viewModel;
  ContactInfo _contactInfo;

  void initState() {
    super.initState();
    _viewModel = YourProfileViewModel(
        buildUserProfileRepo(),
        YourProfileViewModelInput(
          PublishSubject(),
          PublishSubject(),
          PublishSubject(),
        ));

    disposeLater(
      _viewModel.output.contactInfo.listen((result) {
        setState(() {
          _contactInfo = result;
        });
      }),
    );
    disposeLater(
      _viewModel.output.onNextScreen.listen((nextScreen) {
        openNextScreen(context, nextScreen);
      }),
    );
    disposeLater(
      _viewModel.output.onExtraParams.listen((nextScreen) {
        if (nextScreen != null) {
          openNextScreen(context, nextScreen);
        }
      }),
    );
    _viewModel.input.onStart.add(true);
    _viewModel.input.onExtraParams.add(widget.deepLinkResult);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.profileTitle,
      rightButtons: <Widget>[
        AppBarIconWidget(
            icon: AppIcons.notificationsIcon,
            onPressed: () {
              _viewModel.input.onTap.add(
                NextScreen(
                    ScreenType.Notifications, widget.deepLinkResult),
              );
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
              _viewModel.input.onTap.add(
                NextScreen(ScreenType.ContactInfo, widget.deepLinkResult),
              );
            },
          ),
        ],
      ),
    );
  }
}
