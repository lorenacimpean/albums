import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/request_type.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/themes/strings.dart';

class AlbumsRemoteDataSource {
  AppHttpClient _appHttpClient;

  AlbumsRemoteDataSource(this._appHttpClient);

  Stream<AlbumList> getAlbums() {
    try {
      return _appHttpClient
          .request(requestType: RequestType.GET, path: "albums")
          .map((response) {
        return response.statusCode == 200
            ? AlbumList.fromRawJson(response.body)
            : Stream.error(AppStrings.albumListLoadingError);
      });
    } catch (error) {
      return Stream.error(AppStrings.generalError);
    }
  }
}
