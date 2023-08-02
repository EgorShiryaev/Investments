import 'package:flutter/material.dart';

import '../../../app_theme.dart';

class RecentSearchTextCard extends StatelessWidget {
  final String request;
  final void Function() onPress;

  const RecentSearchTextCard({
    super.key,
    required this.request,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: AppTheme.cardContentPadding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  request,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
