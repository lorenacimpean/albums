//
//import 'package:albums/data/model/photos.dart';
//import 'package:albums/data/model/result.dart';
//import 'package:albums/data/api/remote_data_source.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:http/http.dart' as http;
//import 'package:mockito/mockito.dart';
//
//class MockClient extends Mock implements http.Client {
//}
//
//  void main() {
//    final mockClient = MockClient();
//    final RemoteDataSource dataSource =RemoteDataSource();
//
//
//    group('getAlbums', () {
//
//      test(
//          'returns an instance of<Future<Result<dynamic>>>  when the albums api call is successful',
//              () {
//            when(mockClient.get('https://jsonplaceholder.typicode.com/albums'))
//                .thenAnswer((_) async => http.Response('[]', 200));
//            expect(dataSource.getAlbums(), isA <Future<Result<dynamic>>>());
//          });
//      test(
//          'returns an instance of <Future<Result<dynamic>>> when the albums api call is unsuccessful',
//              () {
//            when(mockClient.get('https://jsonplaceholder.typicode.com/albums'))
//                .thenAnswer((_) async => http.Response('[]', 404));
//         expect(dataSource.getAlbums(),  isA <Future<Result<dynamic>>>());
//          });
//
//    });
//    group('getPhotos', () {
//      test(
//          'returns an instance of<Future<Result<dynamic>>>  when the photos api call is successful',
//              ()  {
//            when(mockClient
//                .get('https://jsonplaceholder.typicode.com/albums/1/photos'))
//                .thenAnswer((_) async => http.Response('[]', 200));
//            expect(
//                dataSource.getPhotos(1),
//                isA <Future<Result<dynamic>>>());
//          });
//      test(
//          'returns an instance of <Future<Result<dynamic>>>  when the photos api call results in error',
//              ()  {
//            when(mockClient.get(
//                'https://jsonplaceholder.typicode.com/albums/photos'))
//                .thenAnswer((_) async => http.Response('Not found', 503));
//            expect( dataSource.getPhotos(1), isA <Future<Result<dynamic>>>());
//          });
//      test(
//          'run async and get an instance of <SuccessState<PhotoList>>() for success',
//              () async {
//            when(mockClient
//                .get('https://jsonplaceholder.typicode.com/albums/1/photos'))
//                .thenAnswer((_) async => http.Response('[]', 200));
//            expect( await
//            dataSource.getPhotos(1),
//                isA <SuccessState<PhotoList>>());
//          });
//      test(
//          'run async and get an instance of <SuccessState<PhotoList>>() for success',
//              () async {
//            when(mockClient
//                .get('https://jsonplaceholder.typicode.com/albums/1/photos'))
//                .thenAnswer((_) async => http.Response("", 404));
//            expect( await
//            dataSource.getPhotos(1),
//                isA <SuccessState<PhotoList>>());
//          });
//
//    });
//  }
