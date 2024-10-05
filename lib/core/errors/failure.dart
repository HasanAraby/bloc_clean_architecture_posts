class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerException extends Failure {
  ServerException({required super.errMessage});
}

class CacheException extends Failure {
  CacheException({required super.errMessage});
}
