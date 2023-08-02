import 'dart:convert';

Map<String, dynamic> jsonDecode(String body) {
  return json.decode(body);
}

String jsonEncode(Map<String, dynamic> body) {
  return json.encode(body);
}
