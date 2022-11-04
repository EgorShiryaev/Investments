import '../../api_url.dart';

const _registrationPath = '/registration';

const _authPath = '/auth';

const _favoriteInstrumentsPath = '/favoriteInstruments';

const _instrumentsPath = '/instruments';

Uri getRegistrationUri() {
  return Uri.http(apiUrl, _registrationPath);
}

Uri getAuthUri() {
  return Uri.http(apiUrl, _authPath);
}

Uri getFavoriteInstrumentsUri(Map<String, dynamic>? queryParameters) {
  return Uri.http(apiUrl, _favoriteInstrumentsPath, queryParameters);
}

Uri getInstrumentsUri(Map<String, dynamic>? queryParameters) {
  return Uri.http(apiUrl, _instrumentsPath, queryParameters);
}
