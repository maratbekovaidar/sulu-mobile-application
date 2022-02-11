enum ApiClientExceptionType { network, auth, other, sessionExpired, forbidden }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}
