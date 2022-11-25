import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection.dart';
import '../../blocs/index.dart';
import '../../blocs/search/search_page_content_cubit/search_page_content_state.dart';
import '../../components/unknowed_bloc_state_view.dart';
import 'recent_search_list_cubit_view.dart';
import 'search_instruments_cubit_view.dart';

class SearchPageContentCubitView extends StatefulWidget {
  const SearchPageContentCubitView({super.key});

  @override
  State<SearchPageContentCubitView> createState() =>
      _SearchPageContentCubitViewState();
}

class _SearchPageContentCubitViewState
    extends State<SearchPageContentCubitView> {
  final searchTextController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchPageContentCubit>(
          create: (context) => getIt<SearchPageContentCubit>(),
        ),
        BlocProvider<RecentSearchListCubit>(
          create: (context) => getIt<RecentSearchListCubit>()..load(),
        ),
        BlocProvider<SearchInstrumentsCubit>(
          create: (context) => getIt<SearchInstrumentsCubit>(),
        ),
      ],
      child: BlocBuilder<SearchPageContentCubit, SearchPageContentState>(
        builder: (context, state) {
          if (state is SearchingContentState) {
            return SearchInstrumentsCubitView(
              searchFocusNode: searchFocusNode,
              searchTextController: searchTextController,
            );
          } else if (state is RecentSearchListContentState) {
            return RecentSearchListCubitView(
              searchFocusNode: searchFocusNode,
              searchTextController: searchTextController,
            );
          }
          return const UnknowedfBlocStateView();
        },
      ),
    );
  }

  @override
  void dispose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
