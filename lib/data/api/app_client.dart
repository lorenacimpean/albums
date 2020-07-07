import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../util/nothing.dart';
import '../../util/request_type.dart';
import '../../util/request_type_exception.dart';

class AppHttpClient {
  final Client client;

  AppHttpClient({Client client}) : this.client = client ?? Client();

  static const String _baseUrl = "http://jsonplaceholder.typicode.com";

  Future<Response> request(
      {@required RequestType requestType,
      @required String path,
      dynamic parameter = Nothing}) async {
    switch (requestType) {
      case RequestType.GET:
        return client.get("$_baseUrl/$path");
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}
