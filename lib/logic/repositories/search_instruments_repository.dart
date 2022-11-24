import '../datasources/search_instruments_remote_datsource.dart';
import '../models/instrument_list.dart';

class SearchInstrumentsRepository {
  final SearchInstrumentsRemoteDatasource _remoteDatasource;

  SearchInstrumentsRepository({
    required SearchInstrumentsRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  Future<InstrumentList> search(String query) {
    return _remoteDatasource.search(query);
  }
}
