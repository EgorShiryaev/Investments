import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../logic/models/instrument.dart';

class SearchResultCard extends StatelessWidget {
  final Instrument instrument;
  final void Function(bool) onPressFavoriteIcon;

  const SearchResultCard({
    super.key,
    required this.instrument,
    required this.onPressFavoriteIcon,
  });

  @override
  Widget build(BuildContext context) {
    //TODO добавить проверку является ли этот инструмент добавленным в "Избранные"
    final isSelected = true;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: AppTheme.cardContentPadding,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instrument.ticker,
                    style: textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    instrument.title,
                    style: textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => onPressFavoriteIcon(isSelected),
              icon: Icon(isSelected ? Icons.star_outlined : Icons.star_outline),
            )
          ],
        ),
      ),
    );
  }
}
