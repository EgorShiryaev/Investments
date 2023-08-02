
import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../logic/models/instrument.dart';
import '../../bloc_views/favorites/quotes_cubit_view.dart';

class FavoriteInstrumentCard extends StatelessWidget {
  final Instrument instrument;

  const FavoriteInstrumentCard({
    super.key,
    required this.instrument,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    style: theme.textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    instrument.title,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            QuotesCubitView(instrument: instrument),
          ],
        ),
      ),
    );
  }
}
