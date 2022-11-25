import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/usecases/index.dart';
import 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final QoutesUsecases _usecases;
  QuotesCubit({required QoutesUsecases usecases})
      : _usecases = usecases,
        super(DisconnectedQuotesState());

  void connect() {
    _usecases.quotesStream.listen((event) {
      final map = Map<String, num>.from(event);
      emit(NewDataQuotesState(quotes: map));
    });

    unawaited(
      _usecases.connect().then((value) {
        emit(ConnectedQuotesState());
      }),
    );
  }

  void subscribe(String figi) {
    _usecases.subscribe(figi);
  }

  void unsubscribe(String figi) {
    _usecases.unsubscribe(figi);
  }

  Future<void> dispose() => _usecases.dispose();
}
