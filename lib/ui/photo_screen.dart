import 'package:albums/network/remote_data_source.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  final String url;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();

  PhotoScreen({Key key, @required this.url}) : super(key: key);
}

class _PhotoScreenState extends State<PhotoScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(
            child: closeButton(context),
          ),
          Center(
            child: photoWidget(context),
          ),
        ],
      ),
    );
  }

  Widget photoWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Image.network(widget.url),
    );
  }

  Widget closeButton(BuildContext context) {
    return Container(
      child: Positioned(
        left: 1.0,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 14.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.close, color: Colors.pink),
            ),
          ),
        ),
      ),
    );
  }
}
