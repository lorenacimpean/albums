import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/ui/contact_info/validator.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:albums/widgets/app_rounded_text_button.dart';
import 'package:albums/widgets/app_screen_widget.dart';
import 'package:albums/widgets/base_state.dart';
import 'package:albums/widgets/progress_indicator.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ContactInfoScreen extends StatefulWidget {
  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends BaseState<ContactInfoScreen> {
  ContactInfoViewModel _viewModel;
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

    disposeLater(_viewModel.output.fieldList.listen((list) {
      setState(() {
        _list = list;
      });
    }));

    _viewModel.input.onStart.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppStrings.contactInfo,
      hasBackButton: true,
      rightButtons: <Widget>[
        AppTextButton(
          buttonText: AppStrings.apply,
          onPressed: () {
            _viewModel.input.onApply.add(true);
          },
        ),
      ],
      body: (_list?.isNotEmpty ?? false)
          ? _buildTextFields(context)
          : LoadingIndicator(),
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
                    child: AppInputFieldWidget.fromModel(
                      model:
                          _list.getModelFromFieldType(FieldType.firstNameField),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                      model:
                          _list.getModelFromFieldType(FieldType.lastNameField),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
              child: AppInputFieldWidget.fromModel(
                model: _list.getModelFromFieldType(FieldType.emailAddressField),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model: _list
                            .getModelFromFieldType(FieldType.phoneNumberField)),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            Container(
              padding: EdgeInsets.all(AppPaddings.defaultPadding),
            ),
            AppInputFieldWidget.fromModel(
              model: _list.getModelFromFieldType(FieldType.streetAddressField),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model:
                            _list.getModelFromFieldType(FieldType.cityField)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model: _list
                            .getModelFromFieldType(FieldType.countryField)),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model: _list
                            .getModelFromFieldType(FieldType.zipCodeField)),
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),

            //use location
            AppRoundedTextButton(
              text: AppStrings.useMyLocation,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
