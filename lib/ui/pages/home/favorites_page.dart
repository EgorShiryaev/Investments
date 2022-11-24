import 'package:flutter/material.dart';

import '../../components/page_wrapper.dart';

class FavoritesPage extends StatelessWidget {
  final Widget pageContent;
  const FavoritesPage({super.key, required this.pageContent});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Избранные',
      children: [pageContent],
    );
  }
}
