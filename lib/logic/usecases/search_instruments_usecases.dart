import '../models/instrument_list.dart';
import '../repositories/search_instruments_repository.dart';

class SearchInstrumentsUsecases {
  final SearchInstrumentsRepository _repository;

  SearchInstrumentsUsecases({required SearchInstrumentsRepository repository})
      : _repository = repository;

  Future<InstrumentList> search(String query) {
    return _repository.search(query);
  }
}
