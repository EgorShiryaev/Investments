import 'package:flutter/material.dart';

import 'instrument_type_view.dart';

class InstrumentListView extends StatelessWidget {
  final List<Widget> shares;
  final List<Widget> bonds;
  final List<Widget> futures;
  final List<Widget> etfs;
  final List<Widget> currencies;

  const InstrumentListView({
    super.key,
    required this.shares,
    required this.bonds,
    required this.futures,
    required this.etfs,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (shares.isNotEmpty)
          InstrumentTypeView(
            title: 'Акции',
            children: shares,
          ),
        if (bonds.isNotEmpty)
          InstrumentTypeView(
            title: 'Облигации',
            children: bonds,
          ),
        if (etfs.isNotEmpty)
          InstrumentTypeView(
            title: 'Фонды',
            children: etfs,
          ),
        if (futures.isNotEmpty)
          InstrumentTypeView(
            title: 'Фьючерсы',
            children: futures,
          ),
        if (currencies.isNotEmpty)
          InstrumentTypeView(
            title: 'Валюты',
            children: currencies,
          ),
      ],
    );
  }
}
