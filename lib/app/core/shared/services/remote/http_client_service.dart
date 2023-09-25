import 'package:http/http.dart';

import 'http_client_service_interface.dart';

class HttpClientService implements IHttpClientService {
  final Client _client;

  HttpClientService(this._client);

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) {
    return _client.get(url, headers: headers);
  }
}
