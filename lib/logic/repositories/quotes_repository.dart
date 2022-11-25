import 'dart:developer';

import '../datasources/index.dart';

class QoutesRepository {
  final QuotesRemoteDatasource _remoteDatasource;

  final _subscribes = <String>[];

  QoutesRepository({required QuotesRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  Stream<dynamic> get quotesStream => _remoteDatasource.quotesStream;

  Future<void> connect() => _remoteDatasource.connect();

  void subscribe(String figi) {
    _remoteDatasource.subscribe(figi);
    _subscribes.add(figi);
    log('Subscribe: $figi');
  }

  void unsubscribe(String figi) {
    if (_subscribes.where((element) => element == figi).length == 1) {
      _remoteDatasource.unsubscribe(figi);
    }
    _subscribes.remove(figi);
    log('Unsubscribe: $figi');
  }

  Future<void> dispose() => _remoteDatasource.dispose();
}
