import 'dart:convert';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileRepo {
  static final String key = 'contactInfo';
  Future<SharedPreferences> sharedPreferences;

  Future<Result<ContactInfo>> fetchContactInfo() {
    return getSharedPref().then((sharedPref) {
      String encodedInfo = sharedPref.getString(key);
      return Result<ContactInfo>.success(ContactInfo.fromJson(
          encodedInfo != null ? json.decode(encodedInfo) : null));
    });
  }

  Future<Result<bool>> saveContactInfo(ContactInfo contactInfo) {
    return getSharedPref().then((sharedPref) {
      return sharedPref.setString(key, json.encode(contactInfo?.toJson())).then(
          (value) => value
              ? Result.success(value)
              : Result.error("Could not save contact info!"));
    });
  }

  Future<SharedPreferences> getSharedPref() {
    if (sharedPreferences == null) {
      sharedPreferences = SharedPreferences.getInstance();
    }
    return sharedPreferences;
  }
}
