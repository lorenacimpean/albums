import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/ui/album_list/album_list_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAlbumListViewModel extends Mock implements AlbumListViewModel {}

main() {
  //this doesn't work, viewModel.getAlbums() is null
  test('test getAlbums - success', () async {
    final viewModel = MockAlbumListViewModel();
    Result result = await viewModel.getAlbums();
    when(viewModel.getAlbums()).thenAnswer((_) async => Future.value());
    expectLater(result, isNotNull);
    expectLater(result, isA<SuccessState<AlbumList>>());
  });

  test('test getCurrentAlbum', () async {
    final viewModel = MockAlbumListViewModel();
    Album mockAlbum = Album(userId: 1, id: 1, title: "quidem molestiae enim");
    List<Album> mockAlbums = List<Album>();
    AlbumList albums = AlbumList(albumList: mockAlbums);
    mockAlbums.add(mockAlbum);
    when(viewModel.getCurrentAlbum(albums, 0)).thenAnswer((_) => mockAlbum);
    expect(viewModel.getCurrentAlbum(albums, 0), mockAlbum);
  });
}
