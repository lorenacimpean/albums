import 'dart:async';

import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/request_type.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/themes/strings.dart';

class PhotosRemoteDataSource {
  AppHttpClient _appHttpClient;

  PhotosRemoteDataSource(this._appHttpClient);

  Stream<PhotoList> getPhotos(int id) {
    String path = "albums/$id/photos";
    return _appHttpClient
        .request(requestType: RequestType.GET, path: path)
        .map((response) {
      return response.statusCode == 200
          ? PhotoList.fromRawJson(response.body)
          : Stream<PhotoList>.error(AppStrings.photoListError);
    });
  }
}
