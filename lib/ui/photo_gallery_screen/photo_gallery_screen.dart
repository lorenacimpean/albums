import 'dart:ui';

import 'package:albums/data/model/photos.dart';
import 'package:albums/themes/colors.dart';
import 'package:albums/themes/icons.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:albums/widgets/text_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PhotoGalleryScreen extends StatefulWidget {
  final GalleryDetails galleryDetails;

  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();

  PhotoGalleryScreen({Key key, @required this.galleryDetails})
      : super(key: key);
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  PageController _pageController;
  int _currentPage;

  void initState() {
    super.initState();
    _currentPage = widget.galleryDetails.selectedIndex;
    _pageController = PageController(initialPage: _currentPage);
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Photo> listOfPhotos = widget.galleryDetails.photoList.photos;
    return SafeArea(
      child: Material(
        child: Stack(
          children: <Widget>[
            _buildPages(context, listOfPhotos),
            Align(
              alignment: Alignment.topRight,
              child: AppTextButton(
                buttonText: AppStrings.close,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            DotIndicator(total: listOfPhotos.length, selected: _currentPage),
          ],
        ),
      ),
    );
  }

  Widget _buildPages(BuildContext context, List<Photo> photos) {
    return PageView.builder(
      itemCount: photos.length,
      controller: _pageController,
      onPageChanged: ((page) {
        setState(() {
          _currentPage = page;
        });
      }),
      itemBuilder: (context, int index) {
        return Image(image: NetworkImage(photos[index].url));
      },
      physics: BouncingScrollPhysics(),
    );
  }
}

class DotIndicator extends StatelessWidget {
  static final int max = 5;
  final int selected;
  final int total;

  const DotIndicator({Key key, @required this.total, @required selected})
      : this.selected = selected ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(AppPaddings.largePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            total < 5 ? total : max,
            (index) {
              return Image(
                  image: AppIcons.dotIcon,
                  color: (_computeCurrentDot() == index)
                      ? AppColors.darkBlue
                      : null);
            },
          ),
        ),
      ),
    );
  }

  int _computeCurrentDot() {
    int perPage = total ~/ 5 + 1;
    return (selected ~/ perPage).round();
  }
}
