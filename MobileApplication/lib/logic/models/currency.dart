class Currency {
  // Американский доллар
  static const usd = r'$';
  // Шведская крона
  static const sek = 'sek';
  // Российский рубль
  static const rub = '₽';
  // Норвежская крона
  static const nok = 'nok';
  // Казахстанский тенге
  static const kzt = '〒';
  // Японская иена
  static const jpy = '¥';
  // Гонконгский доллар
  static const hkd = 'hkd';
  //  Фунт стерлингов
  static const gbp = '£';
  //  Евро
  static const eur = '€';
  //  Жэньминьби
  static const cny = '¥';
  //  Канадский доллар
  static const cad = 'сad';
}

String? getCurrenyChar(String unicode) {
  switch (unicode) {
    case 'usd':
      return Currency.usd;
    case 'sek':
      return Currency.sek;
    case 'rub':
      return Currency.rub;
    case 'nok':
      return Currency.nok;
    case 'kzt':
      return Currency.kzt;
    case 'jpy':
      return Currency.jpy;
    case 'hkd':
      return Currency.hkd;
    case 'gbp':
      return Currency.gbp;
    case 'eur':
      return Currency.eur;
    case 'cad':
      return Currency.cad;
  }
  return null;
}
