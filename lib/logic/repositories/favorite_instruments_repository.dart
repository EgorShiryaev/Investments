import '../datasources/favorite_instruments_remote_datasource.dart';
import '../models/instrument.dart';
import '../models/instrument_list.dart';

class FavoriteInstrumentsRepository {
  final FavoriteInstrumentsRemoteDatasource _remoteDatasource;

  FavoriteInstrumentsRepository({
    required FavoriteInstrumentsRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  static InstrumentList _favoriteInstrumentsList = InstrumentList.empty();

  InstrumentList get cachedFavoriteInstruments => _favoriteInstrumentsList;

  Future<InstrumentList> load() async {
    final result = await _remoteDatasource.getAll();

    _favoriteInstrumentsList = result;

    return result;
  }

  Future<void> add(Instrument instrument) {
    return _remoteDatasource.add(instrument.figi);
  }

  Future<void> delete(Instrument instrument) {
    return _remoteDatasource.delete(instrument.figi);
  }
}
