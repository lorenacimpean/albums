import 'package:albums/data/api/albums_remote_data_source.dart';
import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/album_repo.dart';
import 'package:albums/ui/album_list/album_list_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class MockAlbumsRepo extends Mock implements AlbumsRepo {}

class MockAlbumsRemoteDataSource extends Mock
    implements AlbumsRemoteDataSource {}

class MockAppHttpClient extends Mock implements AppHttpClient {}

final Subject<bool> onStart = PublishSubject();
final Subject<Album> onTap = PublishSubject();
final AlbumListViewModelInput input = AlbumListViewModelInput(onTap, onStart);
final MockAlbumsRepo mockAlbumsRepo = MockAlbumsRepo();
final AlbumListViewModel viewModel = AlbumListViewModel(mockAlbumsRepo, input);

main() {
  test('getAlbums', () async {
    Album album1 = Album(userId: 1, id: 1, title: "title 1");
    Album album2 = Album(userId: 2, id: 2, title: "title 2");
    List<Album> list1 = List<Album>();
    list1.add(album1);
    list1.add(album2);
    AlbumList expectedList = AlbumList(albumList: list1);
    when(mockAlbumsRepo.getAlbums()).thenAnswer(
        (_) => Stream.value(Result<AlbumList>.success(expectedList)));

    Stream<Result<AlbumList>> actualResult = viewModel.output.albums;
    expect(actualResult, emits(Result.success(expectedList)));
    viewModel.input.onStart.add(true);
  });
//  test('getAlbums', ()  {
//    when(mockAlbumsRepo.getAlbums())
//        .thenAnswer((_) => Stream.value(Result<AlbumList>.error('error')));
//
//    Stream<Result<AlbumList>> actualResult = viewModel.output.albums;
//    expect(actualResult, emits(Result.error('error')));
//    viewModel.input.onStart.add(true);
//  });


}
