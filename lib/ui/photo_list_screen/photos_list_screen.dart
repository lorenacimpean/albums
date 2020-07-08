//import 'package:albums/data/model/albums.dart';
//import 'package:albums/data/model/photos.dart';
//import 'package:albums/data/model/result.dart';
//import 'package:albums/data/repo/repo_factory.dart';
//import 'package:albums/themes/strings.dart';
//import 'package:albums/ui/album_details/album_details_view_model.dart';
//import 'package:albums/ui/photo_screen/photo_screen.dart';
//import 'package:albums/widgets/app_screen_widget.dart';
//import 'package:albums/widgets/error_widget.dart';
//import 'package:albums/widgets/progress_indicator.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//
//class PhotoListScreen extends StatefulWidget {
//  final Album album;
//
//  @override
//  _PhotoListScreenState createState() => _PhotoListScreenState();
//
//  PhotoListScreen({Key key, @required this.album}) : super(key: key);
//}
//
//class _PhotoListScreenState extends State<PhotoListScreen> {
//  Future<Result> futurePhotos;
//  PhotoListViewModel _viewModel;
//
//  void initState() {
//    super.initState();
//    _viewModel = PhotoListViewModel(buildPhotosRepo());
//    futurePhotos = _viewModel.getPhotos(widget.album.id);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return AppScreen(
//        title: AppStrings.albumListTitle,
//        hasBackButton: true,
//        body: _photoList(context));
//  }
//
//
//}
