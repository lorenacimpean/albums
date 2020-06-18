import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  final String url;
  final int index;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();

  PhotoScreen({Key key, @required this.url, this.index}) : super(key: key);
}

class _PhotoScreenState extends State<PhotoScreen> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(null),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
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
      child: Hero(
        tag: "photoList${widget.index}",
        child: Image.network(widget.url),
      ),
    );
  }
}
