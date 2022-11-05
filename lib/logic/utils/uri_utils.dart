import '../../api_settings.dart';

const _registrationPath = '/registration';

const _authPath = '/auth';

const _favoriteInstrumentsPath = '/favoriteInstruments';

const _instrumentsPath = '/instruments';

String generateUrl() {
  return '$apiUrl:$apiPort';
}

Uri getRegistrationUri() {
  return Uri.http(generateUrl(), _registrationPath);
}

Uri getAuthUri() {
  return Uri.http(generateUrl(), _authPath);
}

Uri getFavoriteInstrumentsUri(Map<String, dynamic>? queryParameters) {
  return Uri.http(generateUrl(), _favoriteInstrumentsPath, queryParameters);
}

Uri getInstrumentsUri(Map<String, dynamic>? queryParameters) {
  return Uri.http(generateUrl(), _instrumentsPath, queryParameters);
}
