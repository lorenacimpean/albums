import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:albums/ui/album_details/album_info_model.dart';
import 'package:albums/ui/album_details/list_item_model.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class MockPhotosRepo extends Mock implements PhotosRepo {}

class MockAlbumDetailsViewModel extends Mock implements AlbumDetailsViewModel {}

void main() {
  final mockPhotosRepo = MockPhotosRepo();
  final viewModel = AlbumDetailsViewModel(
      mockPhotosRepo,
      AlbumDetailsViewModelInput(
        PublishSubject(),
        PublishSubject(),
        PublishSubject(),
      ));
  test('test get data success', () {
    Album album = Album(userId: 1, id: 1, title: "title 1");
    Photo photo = Photo(
      albumId: 1,
      id: 1,
      title: "title 1",
      url: "url",
      thumbnailUrl: "url",
    );
    List<Photo> list = List<Photo>();
    list.add(photo);
    PhotoList photoList = PhotoList(photos: list);
    ListItem albumInfo = ListItem(
        type: ListItemType.albumInfo,
        data: AlbumInfo(
          albumName: album.title,
          albumId: album.id,
          photosCount: photoList.photosCount(),
        ));
    ListItem albumAction = ListItem(
      type: ListItemType.albumAction,
      data: photoList.photosCount(),
    );
    List<ListItem> itemsList = [];
    itemsList.add(albumInfo);
    itemsList.add(albumAction);
    itemsList.addAll(
      (photoList.photos.map(
        (e) => ListItem(type: ListItemType.photo, data: e),
      )),
    );
    Result<List<ListItem>> expectedResult =
        Result<List<ListItem>>.success(itemsList);
    when(mockPhotosRepo.getPhotoList(album.id)).thenAnswer(
      (_) {
        return Stream.value(
        Result.success(photoList),
      );
      },
    );
    Stream<Result<List<ListItem>>> actualResult = viewModel.output.listItems;
    expect(
        actualResult,
        emitsInOrder([
          Result<List<ListItem>>.loading(null),
          expectedResult,
        ]));
    viewModel.input.onStart.add(album);
  });

  test('test get data error', () {
    Result<List<ListItem>> expectedResult =
        Result<List<ListItem>>.error('error');
    Album album = Album(userId: 1, id: 1, title: "title 1");
    when(mockPhotosRepo.getPhotoList(1)).thenAnswer(
      (_) {
        return Stream.value(
        Result.error('error'),
      );
      },
    );
    Stream<Result<List<ListItem>>> actualResult = viewModel.output.listItems;
    expect(
        actualResult,
        emitsInOrder([
          Result<List<ListItem>>.loading(null),
          expectedResult,
        ]));
    viewModel.input.onStart.add(album);
  });


}
