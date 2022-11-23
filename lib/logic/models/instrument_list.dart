import 'instrument.dart';

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

  bool get isEmpty {
    return bonds.isEmpty &&
        currencies.isEmpty &&
        etfs.isEmpty &&
        futures.isEmpty &&
        shares.isEmpty;
  }
}
