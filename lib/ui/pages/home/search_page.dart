import 'package:flutter/material.dart';

import '../../../logic/models/instrument.dart';
import '../../components/form_text_field.dart';
import '../../components/page_wrapper.dart';
import '../../components/search_page/previous_requests_list.dart';
import '../../components/search_page/search_result_instrument_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchTextControlller = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchTextControlller.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void copyPreviousRequest(String previousRequest) {
    searchTextControlller.text = previousRequest;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final previousRequests = ['123', '231', '321'];
    return PageWrapper(
      pageTitle: 'Поиск',
      children: [
        FormTextField(
          label: 'Поиск',
          controller: searchTextControlller,
          focusNode: searchFocusNode,
        ),
        SearchResultInstrumentList(
          shares: shares,
          bonds: bonds,
          currencies: currencies,
          etfs: etfs,
          futures: futures,
        ),
        PreviuosRequiestsList(
          previousRequests: previousRequests,
          onPressItem: copyPreviousRequest,
        ),
      ],
    );
  }
}

final shares = [
  Instrument(
    figi: 'figi',
    ticker: '123',
    title: 'Share 1',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
  Instrument(
    figi: 'figi',
    ticker: '231',
    title: 'Share 2',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
  Instrument(
    figi: 'figi',
    ticker: '321',
    title: 'Share 3',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
];

final bonds = [
  Instrument(
    figi: 'figi',
    ticker: '123',
    title: 'Bond 1',
    lot: 100,
    currency: 'rub',
    type: 'Bond',
  ),
  Instrument(
    figi: 'figi',
    ticker: '231',
    title: 'Bond 2',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
  Instrument(
    figi: 'figi',
    ticker: '321',
    title: 'Bond 3',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
];

final etfs = [
  Instrument(
    figi: 'figi',
    ticker: '123',
    title: 'Etf 1',
    lot: 100,
    currency: 'rub',
    type: 'Bond',
  ),
  Instrument(
    figi: 'figi',
    ticker: '231',
    title: 'Etf 2',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
  Instrument(
    figi: 'figi',
    ticker: '321',
    title: 'Etf 3',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
];

final futures = [
  Instrument(
    figi: 'figi',
    ticker: '123',
    title: 'Futures 1',
    lot: 100,
    currency: 'rub',
    type: 'Bond',
  ),
  Instrument(
    figi: 'figi',
    ticker: '231',
    title: 'Futures 2',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
  Instrument(
    figi: 'figi',
    ticker: '321',
    title: 'Futures 3',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
];

final currencies = [
  Instrument(
    figi: 'figi',
    ticker: '123',
    title: 'Currency 1',
    lot: 100,
    currency: 'rub',
    type: 'Bond',
  ),
  Instrument(
    figi: 'figi',
    ticker: '231',
    title: 'Currency 2',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
  Instrument(
    figi: 'figi',
    ticker: '321',
    title: 'Currency 3',
    lot: 100,
    currency: 'rub',
    type: 'share',
  ),
];
