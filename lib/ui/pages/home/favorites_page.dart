import 'package:flutter/material.dart';

import '../../components/wrappers/page_wrapper.dart';

class FavoritesPage extends StatelessWidget {
  final List<Widget> children;
  const FavoritesPage({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Избранные',
      children: children,
    );
  }
}
