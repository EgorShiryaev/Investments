import '../repositories/index.dart';

class QoutesUsecases {
  final QoutesRepository _repository;

  QoutesUsecases({required QoutesRepository repository})
      : _repository = repository;

  Future<void> connect() => _repository.connect();

  Stream<dynamic> get quotesStream => _repository.quotesStream;

  void subscribe(String figi) => _repository.subscribe(figi);

  void unsubscribe(String figi) => _repository.unsubscribe(figi);

  Future<void> dispose() => _repository.dispose();
}
