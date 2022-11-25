import '../models/quotes.dart';
import '../repositories/index.dart';

class QoutesUsecases {
  final QoutesRepository _repository;

  QoutesUsecases({required QoutesRepository repository})
      : _repository = repository;

  Stream<Qoutes> get quotesStream => _repository.quotesStream;

  void subscribe(String figi) => _repository.subscribe(figi);

  void unsubscribe(String figi) => _repository.unsubscribe(figi);

  Future<void> dispose() => _repository.dispose();
}
