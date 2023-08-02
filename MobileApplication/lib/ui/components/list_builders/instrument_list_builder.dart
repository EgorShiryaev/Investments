import 'package:flutter/cupertino.dart';

import '../../../logic/models/instrument.dart';
import '../../../logic/models/instrument_list.dart';
import 'list_builder.dart';

class InstrumentListBuilder {
  final InstrumentList instrumentList;
  final Widget Function(Instrument) itemBuilder;

  InstrumentListBuilder({
    required this.instrumentList,
    required this.itemBuilder,
  });

  List<Widget> _buildList(
    String listTitle,
    List<Instrument> list,
  ) {
    return ListBuilder(
      listTitle: listTitle,
      list: list,
      itemBuilder: itemBuilder,
    ).build();
  }

  List<Widget> build() {
    return [
      if (instrumentList.shares.isNotEmpty)
        ..._buildList('Акции', instrumentList.shares),
      if (instrumentList.bonds.isNotEmpty)
        ..._buildList('Облигации', instrumentList.bonds),
      if (instrumentList.etfs.isNotEmpty)
        ..._buildList('Фонды', instrumentList.etfs),
      if (instrumentList.futures.isNotEmpty)
        ..._buildList('Фьючерсы', instrumentList.futures),
      if (instrumentList.currencies.isNotEmpty)
        ..._buildList('Валюты', instrumentList.currencies),
    ];
  }
}
