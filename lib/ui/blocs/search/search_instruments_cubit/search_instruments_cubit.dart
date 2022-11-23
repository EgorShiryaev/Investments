import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/usecases/search_instruments_usecases.dart';
import 'search_instruments_state.dart';

class SearchInstrumentsCubit extends Cubit<SearchInstrumentsState> {
  final SearchInstrumentsUsecases _usecases;

  SearchInstrumentsCubit({required SearchInstrumentsUsecases usecases})
      : _usecases = usecases,
        super(StoppedSearchInstrumentsState());

  void search(String query) {
    emit(LoadingSearchInstrumentsState());

    unawaited(
      _usecases.search(query).then((value) {
        if (value.isEmpty) {
          return emit(EmptySearchInstrumentsState(query: query));
        }
        emit(LoadedSearchInstrumentsState(instrumentList: value));
      }).catchError(
        (error) => emit(
          ErrorSearchInstrumentsState(message: error.toString()),
        ),
      ),
    );
  }

  void stopSearch() {
    emit(StoppedSearchInstrumentsState());
  }
}
