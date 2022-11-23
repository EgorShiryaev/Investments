import 'package:flutter/material.dart';

class EmptySearchResultView extends StatelessWidget {
  final String query;
  const EmptySearchResultView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Center(
        child: Text(
          'По запросу "$query" ничего не найдено',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
