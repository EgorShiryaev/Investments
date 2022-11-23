class Instrument {
  final String figi;
  final String ticker;
  final String title;
  final int lot;
  final String currency;
  final String type;

  Instrument({
    required this.figi,
    required this.ticker,
    required this.title,
    required this.lot,
    required this.currency,
    required this.type,
  });

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      figi: json['figi'],
      ticker: json['ticker'],
      title: json['title'],
      lot: json['lot'],
      currency: json['currency'],
      type: json['instrumentType'],
    );
  }
}
