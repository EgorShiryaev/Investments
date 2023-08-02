import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/currency.dart';
import '../../../logic/models/instrument.dart';
import '../../blocs/favorites/quotes_cubit.dart/quotes_cubit.dart';
import '../../blocs/favorites/quotes_cubit.dart/quotes_state.dart';
import '../loading_indicator.dart';

class InstrumentCurrentPrice extends StatefulWidget {
  final Instrument instrument;
  final bool wsIsConnected;

  const InstrumentCurrentPrice({
    super.key,
    required this.instrument,
    required this.wsIsConnected,
  });

  @override
  State<InstrumentCurrentPrice> createState() => _InstrumentCurrentPriceState();
}

class _InstrumentCurrentPriceState extends State<InstrumentCurrentPrice> {
  String? price;

  void countPrice(Map<String, num> quotes) {
    final lotPrice = quotes[widget.instrument.figi];
    if (lotPrice != null) {
      setState(() {
        price = lotPrice.toStringAsFixed(2);
      });
    }
  }

  void blocListner(BuildContext context, QuotesState state) {
    if (state is NewDataQuotesState) {
      countPrice(state.quotes);
    }
  }

  void subscribe([String? figi]) {
    BlocProvider.of<QuotesCubit>(context)
        .subscribe(figi ?? widget.instrument.figi);
  }

  void unsubscribe([String? figi]) {
    BlocProvider.of<QuotesCubit>(context)
        .unsubscribe(figi ?? widget.instrument.figi);
  }

  @override
  void initState() {
    if (widget.wsIsConnected) {
      subscribe();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InstrumentCurrentPrice oldWidget) {
    if (oldWidget.wsIsConnected != widget.wsIsConnected &&
        widget.wsIsConnected) {
      subscribe(widget.instrument.figi);
    } else if (oldWidget.instrument.figi != widget.instrument.figi) {
      unsubscribe(oldWidget.instrument.figi);
      subscribe(widget.instrument.figi);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    unsubscribe();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyChar = getCurrenyChar(widget.instrument.currency) ??
        widget.instrument.currency;
    return BlocListener<QuotesCubit, QuotesState>(
      listener: blocListner,
      child: price == null
          ? const LoadingIndicator(size: Size(25, 25))
          : Text(
              '$price $currencyChar',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
