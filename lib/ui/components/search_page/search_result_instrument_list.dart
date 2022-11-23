import 'package:flutter/material.dart';

import '../../../logic/models/instrument.dart';
import '../../../logic/models/instrument_list.dart';
import '../instrument_list_view.dart';
import 'search_result_card.dart';

class SearchResultInstrumentList extends StatelessWidget {
  final InstrumentList list;
  const SearchResultInstrumentList({
    super.key,
    required this.list,
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
      shares: generateSearchResultList(list.shares),
      bonds: generateSearchResultList(list.bonds),
      currencies: generateSearchResultList(list.currencies),
      etfs: generateSearchResultList(list.etfs),
      futures: generateSearchResultList(list.futures),
    );
  }
}
