import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/request_type.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';

class AlbumsRemoteDataSource {
  AppHttpClient _appHttpClient;

  AlbumsRemoteDataSource(this._appHttpClient);

  Stream<Result<AlbumList>> getAlbums() {
    try {
     return _appHttpClient
          .request(requestType: RequestType.GET, path: "albums")
          .asStream()
          .map((response) {
        if (response.statusCode == 200) {
          return Result<AlbumList>.success(
              AlbumList.fromRawJson(response.body));
        } else {
          return Result.error("Album list is not available");
        }
      });
    } catch (error) {
      return Stream.value(Result.error("Something went wrong!"));
    }
  }
}
