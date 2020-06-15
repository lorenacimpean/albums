import 'package:flutter/material.dart';

class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
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
