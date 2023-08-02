import 'package:http/http.dart' as http;

import '../../api_settings.dart';
import '../../global_variables.dart';
import '../models/instrument_list.dart';
import '../utils/json_utils.dart';
import '../utils/log_utils.dart';
import '../utils/response_code_handler.dart';
import '../utils/uri_utils.dart';

class FavoriteInstrumentsRemoteDatasource {
  final http.Client _clien;

  FavoriteInstrumentsRemoteDatasource({
    required http.Client clien,
  }) : _clien = clien;

  Future<InstrumentList> getAll() async {
    final uuid = currentUser!.uuid;
    final uri = getFavoriteInstrumentsUri({'userUuid': uuid});

    logGetRequest(uri);

    final response = await _clien.get(
      uri,
      headers: defaultRequestHeader,
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return InstrumentList.fromJson(responseBody);
    }
    throw handleFailureResponseCode(response.statusCode, responseBody);
  }

  Future<void> add(String figi) async {
    final uuid = currentUser!.uuid;
    final uri = getFavoriteInstrumentsUri(null);

    final body = jsonEncode({
      'userUuid': uuid,
      'instrumentFigi': figi,
    });

    logPostRequest(uri, body);

    final response = await _clien.post(
      uri,
      body: body,
      headers: defaultRequestHeader,
    );

    if (response.statusCode == 200) {
      return;
    }
    final responseBody = jsonDecode(response.body);
    throw handleFailureResponseCode(response.statusCode, responseBody);
  }

  Future<void> delete(String figi) async {
    final uuid = currentUser!.uuid;
    final uri = getFavoriteInstrumentsUri(null);

    final body = jsonEncode({
      'userUuid': uuid,
      'instrumentFigi': figi,
    });

    logPostRequest(uri, body);

    final response = await _clien.delete(
      uri,
      body: body,
      headers: defaultRequestHeader,
    );

    if (response.statusCode == 200) {
      return;
    }
    final responseBody = jsonDecode(response.body);
    throw handleFailureResponseCode(response.statusCode, responseBody);
  }
}
