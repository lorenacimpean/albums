import 'package:albums/ui/splash_screen/splash_screen.dart';
import 'package:albums/ui/views/album_list_screen.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
