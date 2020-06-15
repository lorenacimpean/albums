import 'dart:async';

import 'package:albums/model/albums.dart';
import 'package:albums/model/result.dart';
import 'package:albums/network/album_client.dart';
import 'package:albums/util/request_type.dart';
import 'package:http/http.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();

  static final RemoteDataSource _apiResponse =
      RemoteDataSource._privateConstructor();

  factory RemoteDataSource() => _apiResponse;
  AlbumClient client = AlbumClient(Client());

  Future<Result> getAlbums() async {
    try {
      final response =
          await client.request(requestType: RequestType.GET, path: "albums");
      if (response.statusCode == 200) {
        return Result<Gallery>.success(Gallery.fromRawJson(response.body));
      } else {
        return Result.error("Album list is not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }
}
