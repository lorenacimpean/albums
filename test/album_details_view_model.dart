import 'package:albums/data/repo/photos_repo.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:mockito/mockito.dart';

class MockPhotosRepo extends Mock implements PhotosRepo {}

class MockAlbumDetailsViewModel extends Mock implements AlbumDetailsViewModel {}

void main() {
//  test('test get photos', () async {
//    final mockPhotosRepo = MockPhotosRepo();
//    final viewModel = AlbumDetailsViewModel(mockPhotosRepo);
//    Photo photo = Photo(
//        albumId: 1, id: 1, title: "title 1", url: "url", thumbnailUrl: "url");
//    List<Photo> list = List<Photo>();
//    list.add(photo);
//    PhotoList photoList = PhotoList(photos: list);
//
//    when(mockPhotosRepo.getPhotoList(0)).thenAnswer(
//        (_) => Future.value(Result.success(photoList) as SuccessState));
//
//    PhotoList actualResult =
//        await viewModel.getPhotos(0).then((value) => photoList);
//    expect(actualResult, isNotNull);
//    expect(actualResult, isA<PhotoList>());
//    expect(actualResult, photoList);
//  });

//  test('test getPhotosCount', () {
//    final mockPhotosRepo = MockPhotosRepo();
//    final viewModel = AlbumDetailsViewModel(mockPhotosRepo);
//    Photo photo = Photo(
//        albumId: 1, id: 1, title: "title 1", url: "url", thumbnailUrl: "url");
//    List<Photo> list = List<Photo>();
//    list.add(photo);
//    PhotoList photoList = PhotoList(photos: list);
//    int actualResult = viewModel.getPhotosCount(photoList);
//    expect(actualResult, isNotNull);
//    expect(actualResult, isA<int>());
//    expect(actualResult, 1);
//  });
}
