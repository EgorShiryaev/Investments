import '../../../../logic/models/instrument_list.dart';

class FavoriteInstrumentsState {}

class InitialFavoriteInstrumentsState extends FavoriteInstrumentsState {}

class RefreshingFavoriteInstrumentsState extends FavoriteInstrumentsState {
  final InstrumentList list;

  RefreshingFavoriteInstrumentsState({required this.list});
}

class LoadingFavoriteInstrumentsState extends FavoriteInstrumentsState {}

class EmptyFavoriteInstrumentsState extends FavoriteInstrumentsState {}

class LoadedFavoriteInstrumentsState extends FavoriteInstrumentsState {
  final InstrumentList list;

  LoadedFavoriteInstrumentsState({required this.list});
}

class ErrorFavoriteInstrumentsState extends FavoriteInstrumentsState {
  final String message;

  ErrorFavoriteInstrumentsState({required this.message});
}
