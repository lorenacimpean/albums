import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';
import 'package:albums/ui/album_list/album_list_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAlbumsRepo extends Mock implements AlbumsRepo {}

class MockAlbumsRemoteDataSource extends Mock
    implements AlbumsRemoteDataSource {}

class MockAppHttpClient extends Mock implements AppHttpClient {}

main() {
  test('test getAlbums - success', () async {
    final mockAlbumsRepo = MockAlbumsRepo();
    final viewModel = AlbumListViewModel(mockAlbumsRepo);
    final jsonAlbum = [
      {"userId": 1, "id": 1, "title": "quidem molestiae enim"},
      {"userId": 1, "id": 2, "title": "sunt qui excepturi placeat culpa"},
    ];

    Result result = Result.success(AlbumList.fromJson(jsonAlbum).albumList);
    //why is this null? mockAlbumsRepo.getAlbums();
    when(await mockAlbumsRepo.getAlbums().then((_) => result));

    Result actualResult = await viewModel.getAlbums();

    expect(actualResult, isNotNull);
    expect(actualResult, result);
  });
}
