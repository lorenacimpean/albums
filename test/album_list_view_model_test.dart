import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/album_repo.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/ui/album_list/album_list_view_model.dart';
import 'package:albums/ui/next_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class MockAlbumsRepo extends Mock implements AlbumsRepo {}

main() {
  final MockAlbumsRepo mockAlbumsRepo = MockAlbumsRepo();
  final Subject<bool> onStart = PublishSubject();
  final Subject<Album> onTap = PublishSubject();
  final AlbumListViewModelInput input = AlbumListViewModelInput(onTap, onStart);
  final AlbumListViewModel viewModel =
      AlbumListViewModel(mockAlbumsRepo, input);
  test('getAlbums success', () {
    Album album1 = Album(userId: 1, id: 1, title: "title 1");
    Album album2 = Album(userId: 2, id: 2, title: "title 2");
    List<Album> list = List<Album>();
    list.add(album1);
    list.add(album2);

    AlbumList expectedList = AlbumList(albumList: list);
    when(mockAlbumsRepo.getAlbums()).thenAnswer((_) {
      return Stream.value(expectedList);
    });
    Stream<Result<AlbumList>> actualResult = viewModel.output.albums;

    expect(
        actualResult,
        emitsInOrder([
          Result<AlbumList>.loading(null),
          Result<AlbumList>.success(expectedList)
        ]));
    viewModel.input.onStart.add(true);
  });

  test('getAlbums error ', () {
    Result<AlbumList> expectedResult =
        Result<AlbumList>.error(AppStrings.generalError);
    when(mockAlbumsRepo.getAlbums()).thenAnswer((_) {
      return Stream.error('error');
    });
    Stream<Result<AlbumList>> actualResult = viewModel.output.albums;
    expect(
      actualResult,
      emitsInOrder([
        Result<AlbumList>.loading(null),
        expectedResult,
      ]),
    );
    viewModel.input.onStart.add(true);
  });

  test('nextScreen ', () {
    Album album = Album(userId: 1, id: 1, title: "title 1");
    NextScreen nextScreen = NextScreen(ScreenType.AlbumDetails, album);

    Stream<NextScreen> actualResult = viewModel.output.onNextScreen;
    expect(actualResult, emits(nextScreen));
    viewModel.input.onTap.add(album);
  });
}
