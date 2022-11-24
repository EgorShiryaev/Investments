import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/instrument.dart';
import '../../../logic/models/instrument_list.dart';
import '../../blocs/index.dart';
import '../instrument_list_view.dart';
import 'search_result_card.dart';

class SearchResultInstrumentList extends StatefulWidget {
  final InstrumentList list;
  const SearchResultInstrumentList({
    super.key,
    required this.list,
  });

  @override
  State<SearchResultInstrumentList> createState() =>
      _SearchResultInstrumentListState();
}

class _SearchResultInstrumentListState
    extends State<SearchResultInstrumentList> {
  List<Widget> generateSearchResultList(List<Instrument> list) {
    return List.generate(list.length, (index) {
      final item = list[index];
      return SearchResultCard(
        instrument: item,
        onPressFavoriteIcon: (isSelected) {
          if (isSelected) {
            BlocProvider.of<FavoriteInstrumentsCubit>(context)
                .delete(item, needUpdateList: true);
          } else {
            BlocProvider.of<FavoriteInstrumentsCubit>(context).add(item);
          }
          setState(() {});
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InstrumentListView(
      shares: generateSearchResultList(widget.list.shares),
      bonds: generateSearchResultList(widget.list.bonds),
      currencies: generateSearchResultList(widget.list.currencies),
      etfs: generateSearchResultList(widget.list.etfs),
      futures: generateSearchResultList(widget.list.futures),
    );
  }
}
