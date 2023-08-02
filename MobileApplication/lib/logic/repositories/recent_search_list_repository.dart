import 'dart:async';

import '../datasources/recent_search_list_local_datasource.dart';

class RecentSearchListRepository {
  final RecentSearchListLocalDatasource _localDatasource;

  RecentSearchListRepository({
    required RecentSearchListLocalDatasource localDatasource,
  }) : _localDatasource = localDatasource;

  static final List<String> _recentSearchList = [];

  Future<void> _loadRecentSearchList() async {
    final items = await _localDatasource.getAll();
    _recentSearchList
      ..clear()
      ..addAll(items);
  }

  Future<List<String>> get recentSearchList async {
    if (_recentSearchList.isEmpty) {
      await _loadRecentSearchList();
    }
    return _recentSearchList;
  }

  Future<void> addRecentSearch(String searchText) async {
    if (_recentSearchList.isEmpty) {
      await _loadRecentSearchList();
    }
    if (!_recentSearchList.contains(searchText)) {
      _recentSearchList.add(searchText);
      unawaited(_localDatasource.add(searchText));
    }
  }

  Future<void> deleteRecentSearch(String searchText) async {
    if (_recentSearchList.isEmpty) {
      await _loadRecentSearchList();
    }
    final index = _recentSearchList.indexOf(searchText);
    _recentSearchList.removeAt(index);
    unawaited(_localDatasource.delete(index));
  }
}
