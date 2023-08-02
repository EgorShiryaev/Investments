import '../../../../logic/models/instrument_list.dart';

class SearchInstrumentsState {}

class StoppedSearchInstrumentsState extends SearchInstrumentsState {}

class LoadingSearchInstrumentsState extends SearchInstrumentsState {}

class LoadedSearchInstrumentsState extends SearchInstrumentsState {
  final InstrumentList instrumentList;

  LoadedSearchInstrumentsState({required this.instrumentList});
}
class EmptySearchInstrumentsState extends SearchInstrumentsState {
  final String query;

  EmptySearchInstrumentsState({required this.query});
}

class ErrorSearchInstrumentsState extends SearchInstrumentsState {
  final String message;

  ErrorSearchInstrumentsState({required this.message});
}
