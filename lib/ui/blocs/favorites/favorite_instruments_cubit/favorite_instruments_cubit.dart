import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/exceptions/api_exceptions.dart';
import '../../../../logic/models/instrument.dart';
import '../../../../logic/usecases/favorite_instruments_usecases.dart';
import 'favorite_instruments_state.dart';

class FavoriteInstrumentsCubit extends Cubit<FavoriteInstrumentsState> {
  final FavoriteInstrumentsUsecases _usecases;

  FavoriteInstrumentsCubit({
    required FavoriteInstrumentsUsecases usecases,
  })  : _usecases = usecases,
        super(InitialFavoriteInstrumentsState());

  void load() {
    emit(LoadingFavoriteInstrumentsState());

    unawaited(
      _usecases.load().then((value) {
        if (value.isEmpty) {
          return emit(EmptyFavoriteInstrumentsState());
        }
        return emit(LoadedFavoriteInstrumentsState(list: value));
      }).catchError(
        (error) =>
            emit(ErrorFavoriteInstrumentsState(message: error.toString())),
      ),
    );
  }

  Future<void> refresh() async {
    emit(
      RefreshingFavoriteInstrumentsState(
        list: _usecases.cachedFavoriteInstruments,
      ),
    );
    await _usecases.load().then((value) {
      if (value.isEmpty) {
        return emit(EmptyFavoriteInstrumentsState());
      }
      return emit(LoadedFavoriteInstrumentsState(list: value));
    }).catchError(
      (error) => emit(ErrorFavoriteInstrumentsState(message: error.toString())),
    );
  }

  void add(Instrument instrument) {
    _usecases.cachedFavoriteInstruments.addInstument(instrument);
    emit(
      RefreshingFavoriteInstrumentsState(
        list: _usecases.cachedFavoriteInstruments,
      ),
    );

    unawaited(
      _usecases.add(instrument).then((_) => refresh()).catchError((error) {
        if (error is ItemIsExistsException) {
          return refresh();
        }
        emit(ErrorFavoriteInstrumentsState(message: error.toString()));
      }),
    );
  }

  void delete(Instrument instrument, {bool needUpdateList = false}) {
    _usecases.cachedFavoriteInstruments.deleteInstrument(instrument);
    if (needUpdateList) {
      emit(
        RefreshingFavoriteInstrumentsState(
          list: _usecases.cachedFavoriteInstruments,
        ),
      );
    }

    unawaited(
      _usecases.delete(instrument).then((_) => refresh()).catchError((error) {
        if (error is ItemNotFoundException) {
          return refresh();
        }
        emit(ErrorFavoriteInstrumentsState(message: error.toString()));
      }),
    );
  }

  bool checkInstrumentIsFavorite(Instrument instrument) {
    return _usecases.checkInstrumentIsFavorite(instrument);
  }
}
