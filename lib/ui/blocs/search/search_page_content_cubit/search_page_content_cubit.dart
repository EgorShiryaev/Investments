import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_page_content_state.dart';

class SearchPageContentCubit extends Cubit<SearchPageContentState> {
  SearchPageContentCubit() : super(RecentSearchListContentState());

  void startSearching() {
    emit(SearchingContentState());
  }

  void stopSearching() {
    emit(RecentSearchListContentState());
  }
}
