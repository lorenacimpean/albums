import 'dart:async';

import 'package:albums/data/api/albums_client.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/util/request_type.dart';
import 'package:http/http.dart';

class RemoteDataSource extends AlbumsClient{
   AlbumsClient _albumsClient;
   //TODO:
   // The following NoSuchMethodError was thrown building StreamBuilder<NavBarItem>(state: _StreamBuilderBaseState<NavBarItem, AsyncSnapshot<NavBarItem>>#10f87):
   //The method 'getAlbums' was called on null.
   //Receiver: null
   //Tried calling: getAlbums()
  RemoteDataSource(this._albumsClient): super();
  Future<Result> getAlbums() async {
    try {
      final response =
          await _albumsClient.request(requestType: RequestType.GET, path: "albums");
      if (response.statusCode == 200) {
        return Result<Gallery>.success(Gallery.fromRawJson(response.body));
      } else {
        return Result.error("Album list is not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

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
