import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/search/recent_search_items_cubit/recent_search_items_cubit.dart';
import '../dismissible_wrapper.dart';
import '../separator.dart';
import '../subtitle.dart';
import 'recent_search_item_card.dart';

class RecentSearchItemsView extends StatefulWidget {
  final List<String> items;
  final void Function(String) onPressItem;

  const RecentSearchItemsView({
    super.key,
    required this.items,
    required this.onPressItem,
  });

  @override
  State<RecentSearchItemsView> createState() => _RecentSearchItemsViewState();
}

class _RecentSearchItemsViewState extends State<RecentSearchItemsView> {
  void rightSwipe(int index) {
    final reversedIndex = widget.items.length - 1 - index;
    BlocProvider.of<RecentSearchItemsCubit>(context).delete(reversedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Subtitle(text: 'Недавние'),
        const Separator(height: 10),
        ...List.generate(widget.items.length, (index) {
          final text = widget.items[index];

          return DismissibleWrapper(
            uniqKey: '$text$index',
            onRightSwipe: () => rightSwipe(index),
            child: RecentSearchItemCard(
              request: text,
              onPress: () => widget.onPressItem(text),
            ),
          );
        }),
        const Separator(height: 10),
      ],
    );
  }
}
