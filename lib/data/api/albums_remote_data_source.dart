import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/request_type.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/themes/strings.dart';

class AlbumsRemoteDataSource {
  AppHttpClient _appHttpClient;

  AlbumsRemoteDataSource(this._appHttpClient);

  Stream<Result<AlbumList>> getAlbums() {
    try {
      return _appHttpClient
          .request(requestType: RequestType.GET, path: "albums")
          .map((response) {
        if (response.statusCode == 200) {
          return Result<AlbumList>.success(
              AlbumList.fromRawJson(response.body));
        } else {
          return Result<AlbumList>.error(AppStrings.albumListLoadingError);
        }
      });
    } catch (error) {
      return Stream.value(Result<AlbumList>.error(AppStrings.generalError));
    }
  }
}
