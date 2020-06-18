import 'package:albums/model/photos.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  final Photo photo;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();

  PhotoScreen({Key key, @required this.photo}) : super(key: key);
}

class _PhotoScreenState extends State<PhotoScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PageView(
        children: [
          _closeButton(context),
          _photoWidget(context),
        ],
      )),
    );
  }

  Widget _closeButton(BuildContext context) {
    return Positioned(
      top: 0.0,
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.close),
          iconSize: 30.0,
          color: Colors.pink,
          onPressed: () => Navigator.of(context).pop(null),
        ),
      ),
    );
  }

  Widget _photoWidget(BuildContext context) {
    Photo photo = widget.photo;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Hero(
          tag: "photoList${photo.id}",
          child: Image.network(
            photo.url,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
