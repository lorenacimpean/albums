import 'package:flutter/material.dart';

class PhotosScreen extends StatefulWidget {
  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("placeholder title"),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView.builder(
            //images
            ),
      ),
    );
  }
}
