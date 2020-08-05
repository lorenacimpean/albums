import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const String _key = 'key';
  const String _prefixedKey = 'flutter.' + _key;
  setUpAll(() {
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{
          _prefixedKey: '',
        };
      }
      return null;
    });
  });

  test('test initial values empty', () async {
    String expected = '';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String actual = sharedPreferences.getString(_key);

    expect(actual, expected);
  });

  test('test initial set and read values', () async {
    String testValue = 'test string 2';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_key, testValue);
    String actualResult = sharedPreferences.getString(_key);

    expect(actualResult, testValue);
  });
}
