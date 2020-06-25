import 'package:albums/themes/colors.dart';
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
      theme: ThemeData(
          primaryColor: AppColors.darkBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )),
      home: SplashScreen(),
    );
  }
}
