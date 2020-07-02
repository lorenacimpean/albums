import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/util/request_type.dart';

class AlbumsRemoteDataSource {
  AppHttpClient _appHttpClient;

  AlbumsRemoteDataSource(this._appHttpClient);

  Future<Result> getAlbums() async {
    try {
      final response = await _appHttpClient.request(
          requestType: RequestType.GET, path: "albums");
      if (response.statusCode == 200) {
        return Result<AlbumList>.success(AlbumList.fromRawJson(response.body));
      } else {
        return Result.error("Album list is not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }
}
