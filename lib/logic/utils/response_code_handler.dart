import '../exceptions/api_exceptions.dart';

Exception handleFailureResponseCode(int statusCode, Map<String, dynamic> body) {
  switch (statusCode) {
    case 400:
      return ParameterNotFoundException(errors: body['errors']);
    case 402:
      return ItemIsExistsException();
    case 404:
      return ItemNotFoundException();
    case 500:
      return ServerErrorException(message: body);
  }

  return Exception(body);
}
