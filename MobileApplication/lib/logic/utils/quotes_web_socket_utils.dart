import 'dart:convert';

String getSinkJson(String figi, {required bool isSubscribe}) {
  return json.encode(
    {'operation': isSubscribe ? 'subscribe' : 'unsubscribe', 'figi': figi},
  );
}
