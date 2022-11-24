import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/usecases/recent_search_list_usecases.dart';
import 'recent_search_list_state.dart';

class RecentSearchListCubit extends Cubit<RecentSearchListState> {
  final RecentSearchListUsecases _usecases;
  RecentSearchListCubit({required RecentSearchListUsecases usecases})
      : _usecases = usecases,
        super(InitialRecentSearchListState());

  void load() {
    emit(LoadingRecentSearchListState());
    unawaited(
      _usecases.recentSearchList.then((value) {
        if (value.isEmpty) {
          return emit(EmptyRecentSearchListState());
        }
        return emit(LoadedRecentSearchListState(recentSearchList: value));
      }).catchError((error) {
        emit(ErrorRecentSearchListState(message: error.toString()));
      }),
    );
  }

  void add(String searchText) {
    unawaited(
      _usecases
          .addRecentSearch(searchText)
          .then((value) => load())
          .catchError((error) {
        emit(ErrorRecentSearchListState(message: error.toString()));
      }),
    );
  }

  void delete(String searchText) {
    unawaited(
      _usecases
          .deleteRecentSearch(searchText)
          .then((value) => load())
          .catchError((error) {
        emit(ErrorRecentSearchListState(message: error.toString()));
      }),
    );
  }
}
