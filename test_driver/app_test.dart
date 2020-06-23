import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Albums app', () {
    FlutterDriver driver;
    final title = find.byValueKey('title');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('has correct title', () async {
      await Future.delayed(Duration(seconds: 5));
      expect(await driver.getText(title), "Albums");
    });
  });
}
