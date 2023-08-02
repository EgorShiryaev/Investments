import 'package:flutter/cupertino.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      child: Center(
        child: Text(
          'Список избранных ещё пуст',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
