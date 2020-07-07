import 'package:albums/data/api/app_client.dart';
import 'package:albums/util/request_type.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements Client {}

void main() {
  test('test response success', () async {
    final mockClient = MockClient();
    final appClient = AppHttpClient(client: mockClient);
    final url = "http://jsonplaceholder.typicode.com/albums";
    String jsonAlbumTitle = 'title": "quidem molestiae enim"';

    Response clientResponse = Response("response", 200);
    when(await mockClient.get(url)).thenAnswer((_) => clientResponse);

    Response actualResponse =
        await appClient.request(requestType: RequestType.GET, path: 'albums');

    expect(actualResponse, isNotNull);
    expect(actualResponse, isA<Response>());
    expect(actualResponse.statusCode, clientResponse.statusCode);
    expect(actualResponse.statusCode, 200);
    expect(actualResponse.body, isNotEmpty);
    expect(actualResponse.body, contains(jsonAlbumTitle));
  });

  test('test response -  not found', () async {
    final mockClient = MockClient();
    final appClient = AppHttpClient(client: mockClient);
    final url = "incorrect url";

    Response clientResponse = Response("response", 404);
    when(await mockClient.get(url)).thenAnswer((_) => clientResponse);

    Response actualResponse =
        await appClient.request(requestType: RequestType.GET, path: url);
    expect(actualResponse, isNotNull);
    expect(actualResponse, isA<Response>());
    expect(actualResponse.statusCode, clientResponse.statusCode);
    expect(actualResponse.statusCode, 404);
    expect(actualResponse.body, isNotEmpty);
    expect(actualResponse.body, "{}");
  });
}
