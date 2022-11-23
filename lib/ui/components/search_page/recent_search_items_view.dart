import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/recent_search_items_cubit/recent_search_items_cubit.dart';
import '../separator.dart';
import '../subtitle.dart';
import 'recent_search_item_card.dart';

class RecentSearchItemsView extends StatelessWidget {
  final List<String> items;
  final void Function(String) onPressItem;

  const RecentSearchItemsView({
    super.key,
    required this.items,
    required this.onPressItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Subtitle(text: 'Недавние'),
        const Separator(height: 10),
        ...List.generate(items.length, (index) {
          final requestText = items[index];
          return RecentSearchItemCard(
            request: requestText,
            onPress: () => onPressItem(requestText),
            delete: () => BlocProvider.of<RecentSearchItemsCubit>(context)
                .delete(items.length - 1 - index),
          );
        }),
        const Separator(height: 10),
      ],
    );
  }
}
