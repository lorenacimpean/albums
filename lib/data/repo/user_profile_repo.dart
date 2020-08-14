import 'dart:convert';

import 'package:albums/data/model/contact_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileRepo {
  static final String key = 'contactInfo';

  Stream<ContactInfo> fetchContactInfo() {
    return SharedPreferences.getInstance().then((sharedPref) {
      String encodedInfo = sharedPref.getString(key);
      return ContactInfo.fromJson(
          encodedInfo != null ? json.decode(encodedInfo) : null);
    }).asStream();
  }

  Stream<bool> saveContactInfo(ContactInfo contactInfo) {
    return SharedPreferences.getInstance().then((sharedPref) {
      return sharedPref
          .setString(key, json.encode(contactInfo?.toJson()))
          .then((_) {
        return true;
      });
    }).asStream();
  }
}
