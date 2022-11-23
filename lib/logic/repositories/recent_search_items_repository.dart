import 'dart:async';

import '../datasources/recent_search_items_local_datasources.dart';

class RecentSearchItemsRepository {
  final RecentSearchItemsLocalDatasource _localDatasource;

  RecentSearchItemsRepository({
    required RecentSearchItemsLocalDatasource localDatasource,
  }) : _localDatasource = localDatasource;

  static final List<String> _recentSearchItems = [];

  Future<void> _loadRecentSearchItems() async {
    final items = await _localDatasource.getAll();
    _recentSearchItems
      ..clear()
      ..addAll(items);
  }

  Future<List<String>> get recentSearchItems async {
    if (_recentSearchItems.isEmpty) {
      await _loadRecentSearchItems();
    }
    return _recentSearchItems;
  }

  Future<void> addRecentSearch(String searchText) async {
    if (_recentSearchItems.isEmpty) {
      await _loadRecentSearchItems();
    }
    if (!_recentSearchItems.contains(searchText)) {
      _recentSearchItems.add(searchText);
      unawaited(_localDatasource.add(searchText));
    }
  }

  Future<void> deleteRecentSearch(int index) async {
    if (_recentSearchItems.isEmpty) {
      await _loadRecentSearchItems();
    }
    _recentSearchItems.removeAt(index);
    unawaited(_localDatasource.delete(index));
  }
}
