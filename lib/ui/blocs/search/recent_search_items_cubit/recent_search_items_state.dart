abstract class RecentSearchItemsState {}

class InitialRecentSearchItemsState extends RecentSearchItemsState {}

class LoadingRecentSearchItemsState extends RecentSearchItemsState {}

class EmptyRecentSearchItemsState extends RecentSearchItemsState {}

class LoadedRecentSearchItemsState extends RecentSearchItemsState {
  final List<String> recentSearchItems;

  LoadedRecentSearchItemsState({required this.recentSearchItems});
}

class ErrorRecentSearchItemsState extends RecentSearchItemsState {
  final String message;

  ErrorRecentSearchItemsState({required this.message});
}
