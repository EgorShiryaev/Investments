import 'dart:developer';

import '../datasources/index.dart';
import '../models/quotes.dart';

class QoutesRepository {
  final QuotesRemoteDatasource _remoteDatasource;

  final _subscribes = <String>[];

  QoutesRepository({required QuotesRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  Stream<Qoutes> get quotesStream => _remoteDatasource.quotesStream;

  void subscribe(String figi) {
    _remoteDatasource.subscribe(figi);
    _subscribes.add(figi);
    log('Subscribes: $_subscribes');
  }

  void unsubscribe(String figi) {
    if (_subscribes.where((element) => element == figi).length == 1) {
      _remoteDatasource.unsubscribe(figi);
    }
    _subscribes.remove(figi);
    log('Subscribes: $_subscribes');
  }

  Future<void> dispose() => _remoteDatasource.dispose();
}
