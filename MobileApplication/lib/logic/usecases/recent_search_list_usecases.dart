import '../repositories/recent_search_list_repository.dart';

class RecentSearchListUsecases {
  final RecentSearchListRepository _repository;

  RecentSearchListUsecases({required RecentSearchListRepository repository})
      : _repository = repository;

  Future<List<String>> get recentSearchList => _repository.recentSearchList;

  Future<void> addRecentSearch(String searchText) {
    return _repository.addRecentSearch(searchText);
  }

  Future<void> deleteRecentSearch(String searchText) {
    return _repository.deleteRecentSearch(searchText);
  }
}
