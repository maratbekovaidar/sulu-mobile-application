import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:sulu_mobile_application/configuration/configuration.dart';

import 'api_client_exception.dart';

class NetworkClient {


  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {

    final uri = Uri.parse('${Configuration.host}$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  void _validateResponse(http.Response response) {
    if (response.statusCode == 401) {

        throw ApiClientException(ApiClientExceptionType.auth);

      }
    else if(response.statusCode == 403){
      throw ApiClientException(ApiClientExceptionType.forbidden);
    }
    }


  Future<T> get<T>({
    required String path,
    required Function(dynamic json) parser,
    Map<String, String>? parameters,
    Map<String, String>? headerParameters,
  }) async {
    final url = _makeUri(path, parameters);
    try {
      var response = await http.get
        (url,
          headers: headerParameters);

      _validateResponse(response);
      final result = parser(response);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  /// Post request for all [TEMPLATE]
  // TODO add parser for all requests

//
//   Future<T> post<T>(
//       String path,
//       Map<String, dynamic> bodyParameters,
//       T Function(dynamic json) parser, [
//         Map<String, dynamic>? urlParameters,
//       ]) async {
//     try {
//       final url = _makeUri(path, urlParameters);
//       final request = await _client.postUrl(url);
//
//       request.headers.contentType = ContentType.json;
//       request.write(jsonEncode(bodyParameters));
//       final response = await request.close();
//       final dynamic json = (await response.jsonDecode());
//       _validateResponse(response, json);
//
//       final result = parser(json);
//       return result;
//     } on SocketException {
//       throw ApiClientException(ApiClientExceptionType.network);
//     } on ApiClientException {
//       rethrow;
//     } catch (e) {
//       throw ApiClientException(ApiClientExceptionType.other);
//     }
//   }
//
//   void _validateResponse(HttpClientResponse response, dynamic json) {
//     if (response.statusCode == 401) {
//       final dynamic status = json['status_code'];
//       final code = status is int ? status : 0;
//       if (code == 30) {
//         throw ApiClientException(ApiClientExceptionType.auth);
//       } else if (code == 3) {
//         throw ApiClientException(ApiClientExceptionType.sessionExpired);
//       } else {
//         throw ApiClientException(ApiClientExceptionType.other);
//       }
//     }
//   }
// }
//
// extension HttpClientResponseJsonDecode on HttpClientResponse {
//   Future<dynamic> jsonDecode() async {
//     return transform(utf8.decoder).toList().then((value) {
//       final result = value.join();
//       return result;
//     }).then<dynamic>((v) => json.decode(v));
//   }
}
