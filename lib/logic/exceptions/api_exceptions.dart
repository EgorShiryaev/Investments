class ParameterNotFoundException implements Exception {
  final dynamic message;

  ParameterNotFoundException({this.message});
}

class ItemIsExistsException implements Exception {}

class ItemNotFoundException implements Exception {}

class ServerErrorException implements Exception {
  final dynamic message;

  ServerErrorException({this.message});
}
