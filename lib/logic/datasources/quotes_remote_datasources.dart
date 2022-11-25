import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../models/quotes.dart';
import '../utils/quotes_web_socket_utils.dart';
import '../utils/uri_utils.dart';

class QuotesRemoteDatasource {
  WebSocket? _websocketChannel;
  StreamSubscription<dynamic>? _websocketListner;
  final _quotesStreamController = StreamController<Qoutes>();

  Stream<Qoutes> get quotesStream => _quotesStreamController.stream;

  void subscribe(String figi) {
    unawaited(
      _checkConnectToWS().then((_) {
        _websocketChannel!.add(getSinkJson(figi, isSubscribe: true));
      }),
    );
  }

  void unsubscribe(String figi) {
    unawaited(
      _checkConnectToWS().then((_) {
        _websocketChannel!.add(getSinkJson(figi, isSubscribe: false));
      }),
    );
  }

  Future<void> dispose() async {
    if (_websocketChannel != null) {
      await _websocketChannel!.close();
    }

    if (_websocketListner != null) {
      await _websocketListner!.cancel();
    }
  }

  Future<void> _checkConnectToWS() async {
    if (_websocketChannel == null) {
      return _connect();
    } else if (_websocketListner == null) {
      return _setupWebSocketListner();
    }
  }

  Future<void> _connect() async {
    if (_websocketChannel == null) {
      await WebSocket.connect(getQuotesUrl()).then(
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

        _quotesStreamController
            .add(response['quotations'] as Map<String, double>);
      },
      onDone: _connect,
      onError: (e) {
        log('Server error: $e');
        _connect();
      },
    );
  }
}
