import 'dart:ui';

import 'package:albums/data/model/photos.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PhotoScreen extends StatefulWidget {
  final List<Photo> photos;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();

  PhotoScreen({Key key, @required this.photos}) : super(key: key);
}

class _PhotoScreenState extends State<PhotoScreen> {
  PageController _pageController;

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, int index) {
            List<Photo> listOfPhotos = widget.photos;
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(AppPaddings.largePadding),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        child: Text(
                          "Close",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onTap: () => Navigator.pop(context),
                      )),
                ),
                Positioned.fill(
                    child: Image(image: NetworkImage(listOfPhotos[index].url))),
                Padding(
                  padding: EdgeInsets.all(AppPaddings.largePadding),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DotIndicator(
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isSelected;
  final int index;

  const DotIndicator({Key key, @required this.isSelected, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddings.largePadding),
      child: Row(
          children: List.generate(
              5,
              (index) => Image(
                  image: AppIcons.dotIcon,
                  color: isSelected ? AppColors.darkBlue : null))),
    );
  }
}
