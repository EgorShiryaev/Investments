import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/search/recent_search_list_cubit/recent_search_list_cubit.dart';
import '../../blocs/search/recent_search_list_cubit/recent_search_list_state.dart';
import '../../blocs/search/search_instruments_cubit/search_instruments_cubit.dart';
import '../../blocs/search/search_page_content_cubit/search_page_content_cubit.dart';
import '../../components/list_builders/list_builder.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/search_page/recent_search_text_card.dart';
import '../../components/unknowed_bloc_state_view.dart';
import '../../components/wrappers/dismissible_wrapper.dart';
import '../../pages/home/search_page.dart';

class RecentSearchListCubitView extends StatefulWidget {
  final TextEditingController searchTextController;
  final FocusNode searchFocusNode;

  const RecentSearchListCubitView({
    super.key,
    required this.searchTextController,
    required this.searchFocusNode,
  });

  @override
  State<RecentSearchListCubitView> createState() =>
      _RecentSearchListCubitViewState();
}

class _RecentSearchListCubitViewState extends State<RecentSearchListCubitView> {
  void listner(BuildContext context, RecentSearchListState state) {
    if (state is ErrorRecentSearchListState) {
      ErrorModal.show(context, message: state.message);
    }
  }

  void search(String text) {
    widget.searchTextController.text = text;
    BlocProvider.of<SearchPageContentCubit>(context).startSearching();
    BlocProvider.of<SearchInstrumentsCubit>(context).search(text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecentSearchListCubit, RecentSearchListState>(
      listener: listner,
      child: BlocBuilder<RecentSearchListCubit, RecentSearchListState>(
        builder: (context, state) {
          return SearchPage(
            searchTextController: widget.searchTextController,
            searchFocusNode: widget.searchFocusNode,
            children: [
              if (state is InitialRecentSearchListState)
                 const LoadingIndicator()
              else if (state is LoadingRecentSearchListState)
                 const LoadingIndicator()
              else if (state is EmptyRecentSearchListState)
                const SizedBox.shrink()
              else if (state is LoadedRecentSearchListState)
                ..._buildList(state.recentSearchList, context)
              else if (state is ErrorRecentSearchListState)
                const SizedBox.shrink()
              else
                const UnknowedfBlocStateView()
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildList(List<String> list, BuildContext context) {
    return ListBuilder(
      listTitle: 'Недавние',
      list: list.reversed.toList(),
      itemBuilder: (text) {
        return DismissibleWrapper(
          uniqKey: text,
          onRightSwipe: () {
            BlocProvider.of<RecentSearchListCubit>(context).delete(text);
          },
          child: RecentSearchTextCard(
            request: text,
            onPress: () => search(text),
          ),
        );
      },
    ).build();
  }
}
