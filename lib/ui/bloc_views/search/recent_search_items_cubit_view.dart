import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/recent_search_items_cubit/recent_search_items_cubit.dart';
import '../../blocs/recent_search_items_cubit/recent_search_items_state.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/search_page/recent_search_items_view.dart';
import '../../components/unknowed_bloc_state_view.dart';

class RecentSearchItemsCubitView extends StatelessWidget {
  final void Function(String) onPressItem;
  const RecentSearchItemsCubitView({super.key, required this.onPressItem});

  void listner(BuildContext context, RecentSearchItemsState state) {
    if (state is ErrorRecentSearchItemsState) {
      ErrorModal.show(context, message: state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecentSearchItemsCubit, RecentSearchItemsState>(
      listener: listner,
      child: BlocBuilder<RecentSearchItemsCubit, RecentSearchItemsState>(
        builder: (context, state) {
          if (state is InitialRecentSearchItemsState) {
            return const LoadingIndicator();
          } else if (state is LoadingRecentSearchItemsState) {
            return const LoadingIndicator();
          } else if (state is EmptyRecentSearchItemsState) {
            return const SizedBox.shrink();
          } else if (state is LoadedRecentSearchItemsState) {
            return RecentSearchItemsView(
              onPressItem: onPressItem,
              items: state.recentSearchItems.reversed.toList(),
            );
          } else if (state is ErrorRecentSearchItemsState) {
            return const SizedBox.shrink();
          }
          return const UnknowedfBlocStateView();
        },
      ),
    );
  }
}
