import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/contact_info/contact_info_view_model.dart';
import 'package:albums/ui/contact_info/validator.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/widgets/app_center_continer_widget.dart';
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
  Result<List<AppInputFieldModel>> _result;

  @override
  void initState() {
    super.initState();
    _viewModel = ContactInfoViewModel(
      ContactInfoViewModelInput(
        PublishSubject(),
        PublishSubject(),
        PublishSubject(),
        PublishSubject(),
      ),
      buildUserProfileRepo(),
      AppTextValidator(),
      buildLocationRepo(),
    );

    disposeLater(
      _viewModel.output.fieldList.listen((result) {
        setState(() {
          _result = result;
        });
      }, onError: (e) {
        handleError(
          error: (e),
        );
      }),
    );
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    List<AppInputFieldModel> list;
    String error;
    if (_result is SuccessState<List<AppInputFieldModel>>)
      list = (_result as SuccessState<List<AppInputFieldModel>>).value;
    if (_result is LoadingState<List<AppInputFieldModel>>)
      list = (_result as LoadingState<List<AppInputFieldModel>>).value;
    if (_result is ErrorState)
      error = (_result as ErrorState<List<AppInputFieldModel>>).msg;
    return Stack(
      children: <Widget>[
        if (list?.isNotEmpty ?? false) _buildTextFields(list),
        if (_result is LoadingState) LoadingIndicator(),
        if (_result is ErrorState) _buildError(error),
      ],
    );
  }

  Widget _buildTextFields(List<AppInputFieldModel> list) {
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
                          list.getModelFromFieldType(FieldType.firstNameField),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                      model:
                          list.getModelFromFieldType(FieldType.lastNameField),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
              child: AppInputFieldWidget.fromModel(
                model: list.getModelFromFieldType(FieldType.emailAddressField),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model: list
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
              model: list.getModelFromFieldType(FieldType.streetAddressField),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model: list.getModelFromFieldType(FieldType.cityField)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPaddings.defaultPadding),
                    child: AppInputFieldWidget.fromModel(
                        model:
                            list.getModelFromFieldType(FieldType.countryField)),
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
                        model:
                            list.getModelFromFieldType(FieldType.zipCodeField)),
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
              onTap: () {
                _viewModel.input.onLocationButtonPressed.add(true);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildError(String error) {
    return AppCenterContainerWidget(
      textColor: AppColors.red,
      borderColor: AppColors.red,
      text: error,
    );
  }
}
