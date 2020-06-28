import 'package:albums/themes/colors.dart';
import 'package:albums/themes/text_styles.dart';
import 'package:albums/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(AlbumsApp());
}

class AlbumsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      title: 'Albums',
      theme: _appTheme(context),
      home: SplashScreen(),
    );
  }

  ThemeData _appTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.darkBlue,
      accentColor: AppColors.lightBlue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedIconTheme: IconThemeData(color: AppColors.white),
        selectedIconTheme: IconThemeData(color: AppColors.lightBlue),
        unselectedLabelStyle: AppTextStyle.navBarDefault,
        selectedLabelStyle: AppTextStyle.navBarSelected,
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.lightBlue,
      ),
    );
  }
}
