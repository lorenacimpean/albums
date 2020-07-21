import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/appy_button_widget.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';

class ContactInfoScreen extends StatefulWidget {
  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.contactInfo,
      hasBackButton: true,
      rightButtons: <Widget>[
        AppTextButton(
          buttonText: AppStrings.apply,
          onPressed: () => {print("Tapped on apply button")},
        ),
      ],
      body: _buildTextFields(context),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.defaultPadding,
                    vertical: AppPaddings.defaultPadding),
                child: AppInputFieldWidget(
                  keyboardType: KeyboardType.textKeyboard,
                  label: AppStrings.firstName,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.defaultPadding,
                    vertical: AppPaddings.defaultPadding),
                child: AppInputFieldWidget(
                  keyboardType: KeyboardType.textKeyboard,
                  label: AppStrings.lastName,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.defaultPadding,
                vertical: AppPaddings.defaultPadding),
            child: AppInputFieldWidget(
              keyboardType: KeyboardType.emailKeyboard,
              label: AppStrings.emailAddress,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.defaultPadding,
                vertical: AppPaddings.defaultPadding),
            child: AppInputFieldWidget(
              keyboardType: KeyboardType.numberKeyboard,
              label: AppStrings.phoneNumber,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(AppPaddings.defaultPadding),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.defaultPadding,
                vertical: AppPaddings.defaultPadding),
            child: AppInputFieldWidget(
              keyboardType: KeyboardType.textKeyboard,
              label: AppStrings.streetAddress,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.defaultPadding,
                    vertical: AppPaddings.defaultPadding),
                child: AppInputFieldWidget(
                  keyboardType: KeyboardType.textKeyboard,
                  label: AppStrings.city,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.defaultPadding,
                    vertical: AppPaddings.defaultPadding),
                child: AppInputFieldWidget(
                  keyboardType: KeyboardType.textKeyboard,
                  label: AppStrings.country,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.defaultPadding,
                vertical: AppPaddings.defaultPadding),
            child: AppInputFieldWidget(
              keyboardType: KeyboardType.numberKeyboard,
              label: AppStrings.zipCode,
            ),
          ),
        ),
        ApplyButton(
          text: AppStrings.apply,
          onTap: () {},
        )
      ],
    );
  }
}
