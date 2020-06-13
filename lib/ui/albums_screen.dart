import 'package:flutter/material.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumsScreen> {
  String _title;

  void initState() {
    super.initState();
  }

  //Method to show progressbar in a dialog
  showProgressDialog() => showDialog(
      context: context, builder: (BuildContext context) => ProgressDialog());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Center(
        child: ListView.builder(
          //list of albums
        ),
      ),
    );
  }
}
