import 'package:flutter/material.dart';

import '../../../logic/models/instrument.dart';
import '../instrument_list_view.dart';
import 'search_result_card.dart';

class SearchResultInstrumentList extends StatelessWidget {
  final List<Instrument> shares;
  final List<Instrument> bonds;
  final List<Instrument> futures;
  final List<Instrument> etfs;
  final List<Instrument> currencies;
  const SearchResultInstrumentList({
    super.key,
    required this.shares,
    required this.bonds,
    required this.futures,
    required this.etfs,
    required this.currencies,
  });

  List<Widget> generateSearchResultList(List<Instrument> list) {
    return List.generate(list.length, (index) {
      return SearchResultCard(
        instrument: list[index],
        onPressFavoriteIcon: (isSelected) {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InstrumentListView(
      shares: generateSearchResultList(shares),
      bonds: generateSearchResultList(bonds),
      currencies: generateSearchResultList(currencies),
      etfs: generateSearchResultList(etfs),
      futures: generateSearchResultList(futures),
    );
  }
}
