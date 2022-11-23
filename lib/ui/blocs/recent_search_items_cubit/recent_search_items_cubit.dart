import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/usecases/recent_search_items_usecases.dart';
import 'recent_search_items_state.dart';

class RecentSearchItemsCubit extends Cubit<RecentSearchItemsState> {
  final RecentSearchItemsUsecases _usecases;
  RecentSearchItemsCubit({required RecentSearchItemsUsecases usecases})
      : _usecases = usecases,
        super(InitialRecentSearchItemsState());

  void load() {
    emit(LoadingRecentSearchItemsState());
    unawaited(
      _usecases.recentSearchItems.then((value) {
        if (value.isEmpty) {
          return emit(EmptyRecentSearchItemsState());
        }
        return emit(LoadedRecentSearchItemsState(recentSearchItems: value));
      }).catchError((error) {
        emit(ErrorRecentSearchItemsState(message: error.toString()));
      }),
    );
  }

  void add(String searchText) {
    unawaited(
      _usecases
          .addRecentSearch(searchText)
          .then((value) => load())
          .catchError((error) {
        emit(ErrorRecentSearchItemsState(message: error.toString()));
      }),
    );
  }

  void delete(int index) {
    unawaited(
      _usecases
          .deleteRecentSearch(index)
          .then((value) => load())
          .catchError((error) {
        emit(ErrorRecentSearchItemsState(message: error.toString()));
      }),
    );
  }
}
