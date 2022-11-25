import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../global_variables.dart';
import '../utils/quotes_web_socket_utils.dart';
import '../utils/uri_utils.dart';

class QuotesRemoteDatasource {
  WebSocket? _websocketChannel;
  StreamSubscription<dynamic>? _websocketListner;
  final _quotesStreamController = StreamController<dynamic>();

  bool connecting = false;

  Stream<dynamic> get quotesStream => _quotesStreamController.stream;

  void subscribe(String figi) {
    _websocketChannel!.add(getSinkJson(figi, isSubscribe: true));
  }

  void unsubscribe(String figi) {
    _websocketChannel!.add(getSinkJson(figi, isSubscribe: false));
  }

  Future<void> dispose() async {
    if (_websocketChannel != null) {
      await _websocketChannel!.close();
    }

    if (_websocketListner != null) {
      await _websocketListner!.cancel();
    }
  }

  Future<void> connect() async {
    if (_websocketChannel == null) {
      final url = getQuotesUrl(currentUser!.uuid);
      await WebSocket.connect(url).then(
        (value) {
          _websocketChannel = value;
          _setupWebSocketListner();
        },
      ).catchError((e) {
        log(e.toString());
      });
    }
  }

  Future<void> _setupWebSocketListner() async {
    if (_websocketListner != null) {
      await _websocketListner!.cancel();
    }
    _websocketListner = _websocketChannel!.listen(
      (event) {
        final Map<String, dynamic> response = jsonDecode(event as String);
        final quotes = response['quotations'];
        if ((quotes as Map<String, dynamic>).isNotEmpty) {
          _quotesStreamController.add(quotes);
        }
      },
      onDone: connect,
      onError: (e) {
        log('Server error: $e');
        connect();
      },
    );
  }
}
