import 'dart:async';

import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/util/request_type.dart';

class PhotosRemoteDataSource {
  AppHttpClient _albumsClient;

  //repo factory
  PhotosRemoteDataSource(this._albumsClient);

  Future<Result> getPhotos(int id) async {
    var path = "albums/$id/photos";
    try {
      final response =
          await _albumsClient.request(requestType: RequestType.GET, path: path);
      if (response.statusCode == 200) {
        return Result<PhotoList>.success(PhotoList.fromRawJson(response.body));
      } else {
        return Result.error("Photo list is not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }
}
