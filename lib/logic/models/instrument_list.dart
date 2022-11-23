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

  factory InstrumentList.fromJson(Map<String, dynamic> json) {
    return InstrumentList(
      shares: (json['shares'] as List<Map<String, dynamic>>)
          .map(Instrument.fromJson)
          .toList(),
      bonds: (json['bonds'] as List<Map<String, dynamic>>)
          .map(Instrument.fromJson)
          .toList(),
      futures: (json['futures'] as List<Map<String, dynamic>>)
          .map(Instrument.fromJson)
          .toList(),
      etfs: (json['etfs'] as List<Map<String, dynamic>>)
          .map(Instrument.fromJson)
          .toList(),
      currencies: (json['currencies'] as List<Map<String, dynamic>>)
          .map(Instrument.fromJson)
          .toList(),
    );
  }
}
