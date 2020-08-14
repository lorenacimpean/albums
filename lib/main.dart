import 'package:albums/themes/app_theme.dart';
import 'package:albums/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // init OneSignal
  OneSignal.shared.init("da85f1be-ea8a-4e55-8688-5b468e25d376", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: true
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(AlbumsApp());
}

class AlbumsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      title: 'Albums',
      theme: AppTheme().appTheme(context),
      home: SplashScreen(),
    );
  }
}
