import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/repositories/index.dart';
import 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final QoutesRepository _repository;
  QuotesCubit({required QoutesRepository repository})
      : _repository = repository,
        super(InitialQuotesState());

  void connect() {
    _repository.quotesStream.listen((event) {
      emit(NewDataQuotesState(quotes: event));
    });
  }

  void subscribe(String figi) {
    _repository.subscribe(figi);
  }

  void unsubscribe(String figi) {
    _repository.unsubscribe(figi);
  }

  Future<void> dispose() => _repository.dispose();
}
