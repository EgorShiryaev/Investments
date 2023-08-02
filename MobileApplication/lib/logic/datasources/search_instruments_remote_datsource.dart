
import 'package:http/http.dart' as http;

import '../../api_settings.dart';
import '../models/instrument_list.dart';
import '../utils/json_utils.dart';
import '../utils/log_utils.dart';
import '../utils/response_code_handler.dart';
import '../utils/uri_utils.dart';

class SearchInstrumentsRemoteDatasource {
  final http.Client _clien;

  SearchInstrumentsRemoteDatasource({
    required http.Client clien,
  }) : _clien = clien;

  Future<InstrumentList> search(String query) async {
    final uri = getInstrumentsUri({'query': query});

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
}
