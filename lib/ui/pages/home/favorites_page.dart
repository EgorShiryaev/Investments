import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/index.dart';
import '../../components/wrappers/page_wrapper.dart';

class FavoritesPage extends StatelessWidget {
  final List<Widget> children;
  final bool isRefresning;
  const FavoritesPage({
    super.key,
    required this.children,
    required this.isRefresning,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return BlocProvider.of<FavoriteInstrumentsCubit>(context).refresh();
      },
      child: PageWrapper(
        pageTitle: 'Избранные',
        children: children,
      ),
    );
  }
}
