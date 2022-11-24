abstract class RecentSearchListState {}

class InitialRecentSearchListState extends RecentSearchListState {}

class LoadingRecentSearchListState extends RecentSearchListState {}

class EmptyRecentSearchListState extends RecentSearchListState {}

class LoadedRecentSearchListState extends RecentSearchListState {
  final List<String> recentSearchList;

  LoadedRecentSearchListState({required this.recentSearchList});
}

class ErrorRecentSearchListState extends RecentSearchListState {
  final String message;

  ErrorRecentSearchListState({required this.message});
}
