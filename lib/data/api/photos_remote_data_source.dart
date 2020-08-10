import 'dart:async';

import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/request_type.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/themes/strings.dart';

class PhotosRemoteDataSource {
  AppHttpClient _appHttpClient;

  PhotosRemoteDataSource(this._appHttpClient);

  Stream<Result<PhotoList>> getPhotos(int id) {
    String path = "albums/$id/photos";
    return _appHttpClient
        .request(requestType: RequestType.GET, path: path)
        .asStream()
        .map((response) {
      if (response.statusCode == 200) {
        return Result<PhotoList>.success(PhotoList.fromRawJson(response.body));
      } else {
        return Result<PhotoList>.error(AppStrings.photoListError);
      }
    });
  }
}
