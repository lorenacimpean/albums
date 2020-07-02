import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/albumsRepo.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAlbumsRemoteDataSource extends Mock
    implements AlbumsRemoteDataSource {}

class MockAppHttpClient extends Mock implements AppHttpClient {}

void main() {
  test('test load albums', () async {
    final mockAlbumsRemoteDataSource = MockAlbumsRemoteDataSource();
    final albumsRepo = AlbumsRepo(mockAlbumsRemoteDataSource);
    final jsonAlbum = [
      {"userId": 1, "id": 1, "title": "quidem molestiae enim"},
      {"userId": 1, "id": 2, "title": "sunt qui excepturi placeat culpa"},
    ];

    Result result = Result.success(AlbumList.fromJson(jsonAlbum));
    when(mockAlbumsRemoteDataSource.getAlbums())
        .thenAnswer((_) => Future.value(result));
    Result actualResult = await albumsRepo.getAlbums();

    expect(actualResult, isNotNull);
    expect(actualResult, result);
  });

  test('test error', () async {
    final mockAlbumsRemoteDataSource = MockAlbumsRemoteDataSource();
    final albumsRepo = AlbumsRepo(mockAlbumsRemoteDataSource);

    Result result = Result.error("error");
    when(mockAlbumsRemoteDataSource.getAlbums())
        .thenAnswer((_) => Future.value(result));
    Result actualResult = await albumsRepo.getAlbums();

    expect(actualResult, isNotNull);
    expect(actualResult, result);
  });
  test('test loading', () async {
    final mockAlbumsRemoteDataSource = MockAlbumsRemoteDataSource();
    final albumsRepo = AlbumsRepo(mockAlbumsRemoteDataSource);

    Result result = Result.loading("loading");
    when(mockAlbumsRemoteDataSource.getAlbums())
        .thenAnswer((_) => Future.value(result));
    Result actualResult = await albumsRepo.getAlbums();

    expect(actualResult, isNotNull);
    expect(actualResult, result);
  });
}
