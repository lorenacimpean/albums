import 'dart:async';

import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:albums/util/validator.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:albums/widgets/use_location_button.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ContactInfoScreen extends StatefulWidget {
  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  ContactInfoViewModel _viewModel;
  StreamSubscription listSubscription;
  List<AppInputFieldModel> _list = [];

  @override
  void initState() {
    super.initState();
    _viewModel = ContactInfoViewModel(
      ContactInfoViewModelInput(
        PublishSubject(),
        PublishSubject(),
        PublishSubject(),
      ),
      buildUserProfileRepo(),
      AppTextValidator(),
    );
    listSubscription =
        _viewModel.output.fieldList.listen((list) => setState(() {
              _list = list;
            }));
    _viewModel.input.onStart.add(true);
  }

  @override
  void dispose() {
    listSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.contactInfo,
      hasBackButton: true,
      rightButtons: <Widget>[
        AppTextButton(
          buttonText: AppStrings.apply,
          onPressed: () => {
            print("Tapped on apply button"),
          },
        ),
      ],
      body: _buildTextFields(context),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(_list.first),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(_list[1]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
              child: AppInputFieldWidget.fromModel(_list[2]),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(_list[3]),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            Container(
              padding: EdgeInsets.all(AppPaddings.defaultPadding),
            ),
            AppInputFieldWidget.fromModel(_list[4]),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(_list[5]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(_list[6]),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(_list[7]),
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),

            //use location
            UseMyLocationButton(
              text: AppStrings.useMyLocation,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
