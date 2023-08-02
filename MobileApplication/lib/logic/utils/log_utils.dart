import 'dart:developer';

void logPostRequest(Uri uri, String body) {
  log('$uri: $body');
}

void logGetRequest(Uri uri) {
  log('$uri');
}
