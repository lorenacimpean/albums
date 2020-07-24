import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/util/extensions.dart';
import 'package:albums/util/validator.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ContactInfoViewModel {
  final ContactInfoViewModelInput input;
  final UserProfileRepo _userProfileRepo;
  ContactInfoViewModelOutput output;
  AppTextValidator _validator = AppTextValidator();
  List<AppInputFieldModel> _list = List<AppInputFieldModel>();

  ContactInfoViewModel(this.input, this._userProfileRepo, this._validator) {
    initFields(_list);
    Stream<List<AppInputFieldModel>> onList = MergeStream([
      input.onStart.map((field) => _list),
      input.onValueChanged.map((field) {
        field.error = null;
        return _list;
      }),
      input.onApply.flatMap((event) {
        _list.forEach((field) {
          field.error = _validator.validate(field);
          if (field.error != null) {
            field.textController.text = field.error;
          }
        });
        if (_list.areAllFieldsValid()) {
          ContactInfo contactInfo =
              ContactInfo.fromAppInputFieldModelList(_list);
          return _userProfileRepo
              .saveContactInfo(contactInfo)
              .asStream()
              .map((event) => _list);
        } else {
          return Stream.value(_list);
        }
      })
    ]);
    output = ContactInfoViewModelOutput(onList);
  }

  initFields(List<AppInputFieldModel> list) {
    FieldType.values.forEach((element) {
      _list.add(AppInputFieldModel(
          fieldType: element,
          textController: TextEditingController(),
          onValueChanged: (model) {
            input.onValueChanged.add(model);
          }));
    });
  }
}

class ContactInfoViewModelInput {
  final Subject<bool> onStart;
  final Subject<bool> onApply;
  final Subject<AppInputFieldModel> onValueChanged;

  ContactInfoViewModelInput(this.onStart, this.onApply, this.onValueChanged);
}

class ContactInfoViewModelOutput {
  final Stream<List<AppInputFieldModel>> fieldList;

  ContactInfoViewModelOutput(this.fieldList);
}
