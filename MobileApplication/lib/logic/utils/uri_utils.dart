import '../../api_settings.dart';

const _registrationPath = '/registration';

const _authPath = '/auth';

const _favoriteInstrumentsPath = '/favoriteInstruments';

const _instrumentsPath = '/instruments';

const baseUrl = '$apiUrl:$apiPort';

Uri getRegistrationUri() {
  return Uri.http(baseUrl, _registrationPath);
}

Uri getAuthUri() {
  return Uri.http(baseUrl, _authPath);
}

Uri getFavoriteInstrumentsUri(Map<String, dynamic>? queryParameters) {
  return Uri.http(baseUrl, _favoriteInstrumentsPath, queryParameters);
}

Uri getInstrumentsUri(Map<String, dynamic>? queryParameters) {
  return Uri.http(baseUrl, _instrumentsPath, queryParameters);
}

String getQuotesUrl(String useruuid) {
  return 'ws://$apiUrl:$quotesPort/$quotesPath?userUuid=$useruuid';
}
