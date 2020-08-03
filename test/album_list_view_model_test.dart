//import 'package:albums/data/api/albums_remote_data_source.dart';
//import 'package:albums/data/api/app_client.dart';
//import 'package:albums/data/model/albums.dart';
//import 'package:albums/data/model/result.dart';
//import 'package:albums/data/repo/album_repo.dart';
//import 'package:albums/ui/album_list/album_list_view_model.dart';
//import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';
//
//class MockAlbumsRepo extends Mock implements AlbumsRepo {}
//
//class MockAlbumsRemoteDataSource extends Mock
//    implements AlbumsRemoteDataSource {}
//
//class MockAppHttpClient extends Mock implements AppHttpClient {}
//
//main() {
//  test('test sort albums', () async {
//    final mockAlbumsRepo = MockAlbumsRepo();
//    final viewModel = AlbumListViewModel(mockAlbumsRepo);
//
//    Album album1 = Album(userId: 1, id: 1, title: "title 1");
//    Album album2 = Album(userId: 2, id: 2, title: "title 2");
//    List<Album> list1 = List<Album>();
//    list1.add(album1);
//    list1.add(album2);
//
//    List<Album> listToBeSorted = List<Album>();
//    listToBeSorted.add(album1);
//    listToBeSorted.add(album2);
//
//    AlbumList expectedList = AlbumList(albumList: list1);
//    AlbumList albums = AlbumList(albumList: listToBeSorted);
//
//    when(mockAlbumsRepo.getAlbums()).thenAnswer(
//        (_) => Future.value(Result.success(expectedList) as SuccessState));
//
//    AlbumList actualResult =
//        await viewModel.getAlbums().then((value) => albums);
//    expect(actualResult.albumList.first, expectedList.albumList.first);
//    expect(actualResult.albumList.last, expectedList.albumList.last);
//  });
//}
