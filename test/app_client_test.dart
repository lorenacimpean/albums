import 'package:albums/data/api/app_client.dart';
import 'package:albums/data/api/request_type.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements Client {}

void main() {
  test('test response success', () async {
    final mockClient = MockClient();
    final appClient = AppHttpClient(client: mockClient);
    final url = "http://jsonplaceholder.typicode.com/albums";
    Response clientResponse = Response("response", 200);
    when(mockClient.get(url)).thenAnswer((_) {
      return Future.value(clientResponse);
    });
    Stream<Response> actualResponse =
        appClient.request(requestType: RequestType.GET, path: 'albums');

    expect(actualResponse, emits(clientResponse));
  });

  test('test response -  not found', () {
    final mockClient = MockClient();
    final appClient = AppHttpClient(client: mockClient);
    final url = "http://jsonplaceholder.typicode.com/albums";
    Response clientResponse = Response("response", 404);
    when(mockClient.get(url)).thenAnswer((_) {
      return Future.value(clientResponse);
    });
    Stream<Response> actualResponse =
        appClient.request(requestType: RequestType.GET, path: 'albums');

    expect(actualResponse, emits(clientResponse));
  });
}
