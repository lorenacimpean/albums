import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/repo/album_repo.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  final mockAlbumsRemoteDataSource = MockAlbumsRemoteDataSource();
  final albumsRepo = AlbumsRepo(mockAlbumsRemoteDataSource);
  test('test load albums - success', () async {
    Album album = Album(userId: 1, id: 1, title: "title 1");
    List<Album> list = List<Album>();
    list.add(album);
    AlbumList expectedList = AlbumList(albumList: list);
    when(mockAlbumsRemoteDataSource.getAlbums()).thenAnswer((_) {
      return Stream.value(expectedList);
    });
    Stream<AlbumList> actualResult = albumsRepo.getAlbums();
    expect(actualResult, isNotNull);
    expect(actualResult, emits(expectedList));
  });

  test('test load albums - error', () async {
    when(mockAlbumsRemoteDataSource.getAlbums()).thenAnswer((_) {
      return Stream.error('error');
    });
    Stream<AlbumList> actualResult = albumsRepo.getAlbums();
    expect(actualResult, isNotNull);
    expect(actualResult, emitsError('error'));
  });

  test('test load albums -  null', () async {
    when(mockAlbumsRemoteDataSource.getAlbums()).thenAnswer((_) {
      return Stream.value(null);
    });
    Stream<AlbumList> actualResult = albumsRepo.getAlbums();
    expect(actualResult, emits(null));
  });
}

class MockAlbumsRemoteDataSource extends Mock
    implements AlbumsRemoteDataSource {}

class MockAppHttpClient extends Mock implements AppHttpClient {}