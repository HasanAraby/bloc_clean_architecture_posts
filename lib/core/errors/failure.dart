class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerException implements Exception {
  final String errMessage;
  ServerException({required this.errMessage});
}

class CacheException implements Exception {
  final String errMessage;
  CacheException({required this.errMessage});
}
