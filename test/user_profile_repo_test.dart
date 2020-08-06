import 'dart:convert';

import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/location_info.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/user_profile_repo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  UserProfileRepo repo = UserProfileRepo();
  String _key = 'contactInfo';
  String _prefixedKey = 'flutter.' + _key;

  test('test initial values empty', () async {
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{
          _prefixedKey: '',
        };
      }
      return null;
    });
    String expected = '';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String actual = sharedPreferences.getString(_key);

    expect(actual, expected);
  });

  test('test initial set and read values', () async {
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{
          _prefixedKey: '',
        };
      }
      return null;
    });
    String testValue = 'test string 2';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_key, testValue);
    String actualResult = sharedPreferences.getString(_key);

    expect(actualResult, testValue);
  });

  test('test fetch contact info', () async {
    LocationInfo locationInfo = LocationInfo(
      streetAddress: "street",
      city: "city",
      country: "country",
      zipCode: "1234",
    );

    ContactInfo contactInfo = ContactInfo(
      firstName: 'firstName',
      lastName: 'lastName',
      emailAddress: 'email',
      phoneNumber: 'phoneNumber',
      locationInfo: locationInfo,
    );

    JsonCodec json = JsonCodec();
    String contactString = json.encode(contactInfo.toJson());

    MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll' &&
          _prefixedKey.contains(UserProfileRepo.key)) {
        return <String, dynamic>{
          _prefixedKey: contactString,
        };
      }
      return null;
    });

    Stream<Result<ContactInfo>> actualResult = repo.fetchContactInfo();
    Result<ContactInfo> expectedResult =
        Result<ContactInfo>.success(contactInfo);

    expect(actualResult, emits(expectedResult));
    expect(actualResult, isNotNull);
  });

  test('test save contact info', () async {
    LocationInfo locationInfo = LocationInfo(
      streetAddress: "street",
      city: "city",
      country: "country",
      zipCode: "1234",
    );

    ContactInfo contactInfo = ContactInfo(
      firstName: 'firstName',
      lastName: 'lastName',
      emailAddress: 'email',
      phoneNumber: 'phoneNumber',
      locationInfo: locationInfo,
    );

    MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll' &&
          _prefixedKey.contains(UserProfileRepo.key)) {
        return <String, dynamic>{
          _prefixedKey: 'contactString',
        };
      }
      return null;
    });

    Stream<Result<bool>> actualResult = repo.saveContactInfo(contactInfo);
    Result<bool> expectedResult = Result<bool>.success(true);

    expect(actualResult, emits(expectedResult));
    expect(actualResult, isNotNull);
  });
}
