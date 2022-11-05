import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../api_settings.dart';
import '../models/login_data.dart';
import '../models/user.dart';
import '../utils/json_utils.dart';
import '../utils/response_code_handler.dart';
import '../utils/uri_utils.dart';

class UserRemoteDatasource {
  final http.Client _clien;

  UserRemoteDatasource({
    required http.Client clien,
  }) : _clien = clien;

  Future<User> login(LoginData data) async {
    final uri = getAuthUri();
    final body = jsonEncode(data.toMap());

    final response = await _clien.post(
      uri,
      body: body,
      headers: defaultRequestHeader,
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(responseBody);
    }
    throw handleFailureResponseCode(response.statusCode, responseBody);
  }

  Future<User> signUp(LoginData data) async {
    final uri = getRegistrationUri();
    final body = jsonEncode(data.toMap());

    final response = await _clien.post(
      uri,
      body: body,
      headers: defaultRequestHeader,
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(responseBody);
    }
    throw handleFailureResponseCode(response.statusCode, responseBody);
  }
}
