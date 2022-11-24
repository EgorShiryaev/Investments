import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/instrument.dart';
import '../../../logic/models/instrument_list.dart';
import '../../blocs/index.dart';
import '../dismissible_wrapper.dart';
import '../instrument_list_view.dart';
import 'favorite_instrument_card.dart';

class FavoriteInstrumentsView extends StatefulWidget {
  final InstrumentList list;
  const FavoriteInstrumentsView({super.key, required this.list});

  @override
  State<FavoriteInstrumentsView> createState() =>
      _FavoriteInstrumentsViewState();
}

class _FavoriteInstrumentsViewState extends State<FavoriteInstrumentsView> {
  List<Widget> generateList(List<Instrument> list) {
    return List.generate(list.length, (index) {
      final item = list[index];
      return DismissibleWrapper(
        uniqKey: item.figi,
        onRightSwipe: () =>
            BlocProvider.of<FavoriteInstrumentsCubit>(context).delete(item),
        child: FavoriteInstrumentCard(
          instrument: item,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InstrumentListView(
      shares: generateList(widget.list.shares),
      bonds: generateList(widget.list.bonds),
      currencies: generateList(widget.list.currencies),
      etfs: generateList(widget.list.etfs),
      futures: generateList(widget.list.futures),
    );
  }
}
