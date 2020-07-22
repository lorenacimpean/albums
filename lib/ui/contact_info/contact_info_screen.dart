import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:albums/widgets/use_location_button.dart';
import 'package:flutter/material.dart';

class ContactInfoScreen extends StatefulWidget {
  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  ContactInfoViewModel _viewModel;
  ContactInfo _contactInfo = ContactInfo();
  StreamSubscription<Error> _textFieldErrorSubscription;
  Error _textFieldError = Error(null, null);

  @override
  void initState() {
    super.initState();
    _viewModel = ContactInfoViewModel(buildUserProfileRepo());
    _textFieldErrorSubscription = _viewModel.error.listen((error) {
      setState(() {
        _textFieldError = error;
      });
    });
  }

  @override
  void dispose() {
    _textFieldErrorSubscription.cancel();
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
            _viewModel.onApply()
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
                    child: AppInputFieldWidget(
                      label: AppStrings.firstName,
                      error: _textFieldError,
                      fieldType: FieldType.firstNameField,
                      onValueChanged: (string) {
                        _viewModel.onValueChanged(
                            string, FieldType.firstNameField);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: AppInputFieldWidget(
                      label: AppStrings.lastName,
                      fieldType: FieldType.lastNameField,
                      error: _textFieldError,
                      onValueChanged: (string) {
                        _viewModel.onValueChanged(
                            string, FieldType.lastNameField);
                      }),
                ),
              ],
            ),
            AppInputFieldWidget(
              label: AppStrings.emailAddress,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget(
                      label: AppStrings.phoneNumber,
                      fieldType: FieldType.phoneNumberField,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            Container(
              padding: EdgeInsets.all(AppPaddings.defaultPadding),
            ),
            AppInputFieldWidget(
              label: AppStrings.streetAddress,
              fieldType: FieldType.streetAddressField,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget(
                      label: AppStrings.city,
                      fieldType: FieldType.cityField,
                    ),
                  ),
                ),
                Expanded(
                  child: AppInputFieldWidget(
                    label: AppStrings.country,
                    fieldType: FieldType.countryField,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget(
                      label: AppStrings.zipCode,
                      fieldType: FieldType.zipCodeField,
                    ),
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
