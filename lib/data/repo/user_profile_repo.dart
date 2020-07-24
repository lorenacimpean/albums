import 'dart:convert';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileRepo {
  static final String key = 'contactInfo';

  Future<Result<ContactInfo>> getContactInfo() {
    return SharedPreferences.getInstance().then((sharedPref) {
      String encodedInfo = sharedPref.getString(key);
      return Result<ContactInfo>.success(ContactInfo.fromJson(
          encodedInfo != null ? json.decode(sharedPref.getString(key)) : null));
    });
  }

  Future<Result<bool>> saveContactInfo(ContactInfo contactInfo) {
   return SharedPreferences.getInstance().then((sharedPref) {
      return sharedPref.setString(key, json.encode(contactInfo?.toJson())).then(
          (value) => value
              ? Result.success(value)
              : Result.error("Could not save contact info!"));
    });
  }
}
