import 'package:flutter/material.dart';

import '../separator.dart';
import '../subtitle.dart';
import 'previous_request_card.dart';

class PreviuosRequiestsList extends StatelessWidget {
  final List<String> previousRequests;
  final void Function(String) onPressItem;

  const PreviuosRequiestsList({
    super.key,
    required this.previousRequests,
    required this.onPressItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Subtitle(text: 'Предыдущие запросы'),
        const Separator(height: 10),
        ...List.generate(previousRequests.length, (index) {
          final requestText = previousRequests[index];
          return PreviousRequestCard(
            request: requestText,
            onPress: () => onPressItem(requestText),
          );
        }),
        const Separator(height: 10),
      ],
    );
  }
}
