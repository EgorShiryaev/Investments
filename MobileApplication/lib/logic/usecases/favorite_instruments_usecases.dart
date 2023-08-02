import '../models/instrument.dart';
import '../models/instrument_list.dart';
import '../repositories/favorite_instruments_repository.dart';

class FavoriteInstrumentsUsecases {
  final FavoriteInstrumentsRepository _repository;

  FavoriteInstrumentsUsecases({
    required FavoriteInstrumentsRepository repository,
  }) : _repository = repository;

  InstrumentList get cachedFavoriteInstruments =>
      _repository.cachedFavoriteInstruments;

  Future<InstrumentList> load() => _repository.load();

  Future<void> add( Instrument instrument) =>
      _repository.add( instrument);

  Future<void> delete( Instrument instrument) =>
      _repository.delete( instrument);

  bool checkInstrumentIsFavorite(Instrument instrument) {
    return _repository.cachedFavoriteInstruments.containsInstrument(instrument);
  }
}
