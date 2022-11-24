import 'instrument.dart';
import 'instrument_type.dart';

class InstrumentList {
  final List<Instrument> shares;
  final List<Instrument> bonds;
  final List<Instrument> futures;
  final List<Instrument> etfs;
  final List<Instrument> currencies;

  InstrumentList({
    required this.shares,
    required this.bonds,
    required this.futures,
    required this.etfs,
    required this.currencies,
  });

  static List<Instrument> _listDynamicToInstruments(
    List<dynamic> list,
  ) {
    return list
        .map((v) => Instrument.fromJson(v as Map<String, dynamic>))
        .toList();
  }

  factory InstrumentList.fromJson(Map<String, dynamic> json) {
    return InstrumentList(
      shares: _listDynamicToInstruments(json['shares']),
      bonds: _listDynamicToInstruments(json['bonds']),
      futures: _listDynamicToInstruments(json['futures']),
      etfs: _listDynamicToInstruments(json['etfs']),
      currencies: _listDynamicToInstruments(json['currencies']),
    );
  }

  factory InstrumentList.empty() {
    return InstrumentList(
      shares: [],
      bonds: [],
      futures: [],
      etfs: [],
      currencies: [],
    );
  }

  bool get isEmpty {
    return bonds.isEmpty &&
        currencies.isEmpty &&
        etfs.isEmpty &&
        futures.isEmpty &&
        shares.isEmpty;
  }

  List<Instrument> _getTypeInstruments(String type) {
    if (type == InstrumentType.share) {
      return shares;
    } else if (type == InstrumentType.bond) {
      return bonds;
    } else if (type == InstrumentType.etf) {
      return etfs;
    } else if (type == InstrumentType.futures) {
      return futures;
    } else if (type == InstrumentType.currency) {
      return currencies;
    }
    return [];
  }

  void addInstument(Instrument instrument) {
    if (!containsInstrument(instrument)) {
      _getTypeInstruments(instrument.type).add(instrument);
    }
  }

  void deleteInstrument(Instrument instrument) {
    if (containsInstrument(instrument)) {
      _getTypeInstruments(instrument.type).removeWhere(
        (element) => element.figi == instrument.figi,
      );
    }
  }

  bool containsInstrument(Instrument instrument) {
    final result = _getTypeInstruments(instrument.type).where(
      (element) => element.figi == instrument.figi,
    );
    return result.isNotEmpty;
  }
}
