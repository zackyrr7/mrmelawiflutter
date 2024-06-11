class NetworkException extends Error {
  final String errorMessage;

  NetworkException({required this.errorMessage});
}
