import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_theme.dart';
import '../../../logic/models/instrument.dart';
import '../../blocs/index.dart';

class SearchResultCard extends StatefulWidget {
  final Instrument instrument;
  final void Function(bool) onPressFavoriteIcon;

  const SearchResultCard({
    super.key,
    required this.instrument,
    required this.onPressFavoriteIcon,
  });

  @override
  State<SearchResultCard> createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  @override
  Widget build(BuildContext context) {
    final isSelected = BlocProvider.of<FavoriteInstrumentsCubit>(context)
        .checkInstrumentIsFavorite(widget.instrument);
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
                    widget.instrument.ticker,
                    style: textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.instrument.title,
                    style: textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                widget.onPressFavoriteIcon(isSelected);
                setState(() {});
              },
              icon: Icon(isSelected ? Icons.star_outlined : Icons.star_outline),
            )
          ],
        ),
      ),
    );
  }
}
