import 'dart:async';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/location_repo.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:albums/ui/contact_info/validator.dart';
import 'package:albums/ui/extensions.dart';
import 'package:albums/widgets/app_input_field_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class ContactInfoViewModel {
  final ContactInfoViewModelInput input;
  final UserProfileRepo _userProfileRepo;
  final AppTextValidator _validator;
  final LocationRepo _locationRepo;
  ContactInfoViewModelOutput output;
  List<AppInputFieldModel> _list = List<AppInputFieldModel>();

  ContactInfoViewModel(
    this.input,
    this._userProfileRepo,
    this._validator,
    this._locationRepo,
  ) {
    Stream<Result<List<AppInputFieldModel>>> onList = MergeStream([
      input.onStart.flatMap((_) => _initFields()),
      input.onValueChanged.map((field) {
        field.error = null;
        _list
            .firstWhere((element) => element.fieldType == field.fieldType,
                orElse: () => null)
            ?.value = field.value;
        return Result<List<AppInputFieldModel>>.success(_list);
      }),
      input.onApply.flatMap((event) {
        _list.forEach((field) {
          field.error = _validator.validate(field);
        });
        if (_list.areAllFieldsValid()) {
          ContactInfo contactInfo = _list.toContactInfo();
          _userProfileRepo.saveContactInfo(contactInfo).map((event) {
            return _list;
          });
        }
        return Stream.value(
          Result<List<AppInputFieldModel>>.success(_list),
        );
      }),
      input.onLocationButtonPressed.flatMap((event) {
        return _locationRepo.getCurrentLocation().flatMap((result) {
          if (result is SuccessState<AppCoordinates>) {
            return _locationRepo
                .decodeUserLocation(result.value)
                .map((address) {
              _updateLocationFields(
                  (address as SuccessState<AppAddress>).value);
              return Result<List<AppInputFieldModel>>.success(_list);
            });
          }
          if (result is ErrorState<AppCoordinates>) {
            return Stream.value(
                Result<List<AppInputFieldModel>>.error(result.msg));
          }
          return Stream.value(
            Result<List<AppInputFieldModel>>.loading(null),
          );
        });
      })
    ]);

    output = ContactInfoViewModelOutput(onList);
  }

  Stream<Result<List<AppInputFieldModel>>> _initFields() {
    return _userProfileRepo
        .fetchContactInfo()
        .map((Result<ContactInfo> result) {
      if (result is SuccessState<ContactInfo>) {
        FieldType.values.forEach((fieldType) {
          String fieldValue = fieldType.fromContactInfo(result.value);
          _list.add(
            AppInputFieldModel(
              fieldType: fieldType,
              value: fieldValue,
              textController: TextEditingController()..text = fieldValue,
              onValueChanged: (model) {
                input.onValueChanged.add(model);
              },
            ),
          );
        });
      }
      return Result<List<AppInputFieldModel>>.success(_list);
    }).startWith(
      Result<List<AppInputFieldModel>>.loading(null),
    );
  }

  void _updateLocationFields(AppAddress address) {
    if (address != null) {
      String street = '${address.featureName} ${address.thoroughfare} ';
      String country = address.countryName;
      String city = address.cityName;
      String zipcode = address.postalCode;
      _list.forEach((model) {
        if (model.fieldType == FieldType.streetAddressField) {
          model.value = street;
          model.textController.text = street;
        }
        if (model.fieldType == FieldType.countryField) {
          model.value = country;
          model.textController.text = country;
        }
        if (model.fieldType == FieldType.cityField) {
          model.value = city;
          model.textController.text = city;
        }
        if (model.fieldType == FieldType.zipCodeField) {
          model.value = zipcode;
          model.textController.text = zipcode;
        }
      });
    }
  }
}

class ContactInfoViewModelInput {
  final Subject<bool> onStart;
  final Subject<bool> onApply;
  final Subject<AppInputFieldModel> onValueChanged;
  final Subject<bool> onLocationButtonPressed;

  ContactInfoViewModelInput(
    this.onStart,
    this.onApply,
    this.onValueChanged,
    this.onLocationButtonPressed,
  );
}

class ContactInfoViewModelOutput {
  final Stream<Result<List<AppInputFieldModel>>> fieldList;

  ContactInfoViewModelOutput(this.fieldList);
}
