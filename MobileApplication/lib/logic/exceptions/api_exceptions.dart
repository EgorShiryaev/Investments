class ParameterNotFoundException implements Exception {
  final List<String> errors;

  ParameterNotFoundException({required this.errors});
}

class ItemIsExistsException implements Exception {}

class ItemNotFoundException implements Exception {}

class ServerErrorException implements Exception {
  final dynamic message;

  ServerErrorException({this.message});
}
