import 'package:albums/data/model/albums.dart';
import 'package:albums/data/model/photos.dart';
import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockPhotosRepo extends Mock implements PhotosRepo {}

class MockAlbumDetailsViewModel extends Mock implements AlbumDetailsViewModel {}

void main() {
  test('test get data success', () async {
    final mockPhotosRepo = MockPhotosRepo();
    final viewModel = AlbumDetailsViewModel(mockPhotosRepo);
    Album album = Album(userId: 1, id: 1, title: "title 1");

    Photo photo = Photo(
        albumId: 1, id: 1, title: "title 1", url: "url", thumbnailUrl: "url");
    List<Photo> list = List<Photo>();
    list.add(photo);
    PhotoList photoList = PhotoList(photos: list);

    ListItem listItem1 = ListItem(
        type: ListItemType.albumInfo,
        data: AlbumInfo(albumName: "title 1", albumId: 1, photosCount: 1));
    ListItem listItem2 = ListItem(type: ListItemType.albumAction, data: 1);
    ListItem listItem3 = ListItem(type: ListItemType.photo, data: photo);
    List<ListItem> itemsList = [];
    itemsList.add(listItem1);
    itemsList.add(listItem2);
    itemsList.add(listItem3);

    when(mockPhotosRepo.getPhotoList(1))
        .thenAnswer((_) => Future.value(Result.success(photoList)));

    List<ListItem> actualResult = await viewModel.getData(album).then((result) {
      return (result as SuccessState<List<ListItem>>).value;
    });

    expect(actualResult, isNotNull);
    expect(actualResult, isA<List<ListItem>>());
    expect(actualResult.first.type, itemsList.first.type);
    expect(actualResult.last.type, itemsList.last.type);
    expect(actualResult.last.data, itemsList.last.data);
  });

  test('test get data error', () async {
    final mockPhotosRepo = MockPhotosRepo();
    final viewModel = AlbumDetailsViewModel(mockPhotosRepo);
    Album album = Album(userId: 1, id: 1, title: "title 1");

    when(mockPhotosRepo.getPhotoList(1))
        .thenAnswer((_) => Future.value(Result.error("error")));
    String actualResult = await viewModel.getData(album).then((result) {
      return (result as ErrorState<List<ListItem>>).msg;
    });
    ;

    expect(actualResult, isNotNull);
    expect(actualResult, "error");
  });
  test('test get data loading', () async {
    final mockPhotosRepo = MockPhotosRepo();
    final viewModel = AlbumDetailsViewModel(mockPhotosRepo);
    Album album = Album(userId: 1, id: 1, title: "title 1");

    when(mockPhotosRepo.getPhotoList(1))
        .thenAnswer((_) => Future.value(Result.loading(null)));
    var actualResult = await viewModel.getData(album).then((result) {
      return (result as LoadingState<List<ListItem>>);
    });
    ;
    expect(actualResult, isNotNull);
    expect(actualResult, isA<LoadingState<List<ListItem>>>());
  });
}
