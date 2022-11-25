import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/instrument.dart';
import '../../blocs/favorites/quotes_cubit.dart/quotes_cubit.dart';
import '../../blocs/favorites/quotes_cubit.dart/quotes_state.dart';
import '../../components/favorites/instrument_current_price.dart';

class QuotesCubitView extends StatelessWidget {
  final Instrument instrument;
  const QuotesCubitView({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuotesCubit, QuotesState>(
      builder: (context, state) {
        final wsIsConnected =
            state is ConnectedQuotesState || state is NewDataQuotesState;
        return InstrumentCurrentPrice(
          instrument: instrument,
          wsIsConnected: wsIsConnected,
        );
      },
    );
  }
}
