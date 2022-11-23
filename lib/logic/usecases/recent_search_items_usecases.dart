import '../repositories/recent_search_items_repository.dart';

class RecentSearchItemsUsecases {
  final RecentSearchItemsRepository _repository;

  RecentSearchItemsUsecases({required RecentSearchItemsRepository repository})
      : _repository = repository;

  Future<List<String>> get recentSearchItems => _repository.recentSearchItems;

  Future<void> addRecentSearch(String searchText) {
    return _repository.addRecentSearch(searchText);
  }

  Future<void> deleteRecentSearch(int index) {
    return _repository.deleteRecentSearch(index);
  }
}
