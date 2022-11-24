import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../blocs/favorites/favorite_instruments_cubit/favorite_instruments_cubit.dart';
import '../../blocs/favorites/favorite_instruments_cubit/favorite_instruments_state.dart';
import '../../components/favorites/empty_favorites_view.dart';
import '../../components/favorites/favorite_instruments_view.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/unknowed_bloc_state_view.dart';
import '../../pages/home/favorites_page.dart';

class FavoriteInstrumentsCubitView extends StatelessWidget {
  const FavoriteInstrumentsCubitView({super.key});

  void blocListner(BuildContext context, FavoriteInstrumentsState state) {
    if (state is LoadedFavoriteInstrumentsState ||
        state is EmptyFavoriteInstrumentsState) {
      FlutterNativeSplash.remove();
    }
    if (state is ErrorFavoriteInstrumentsState) {
      ErrorModal.show(
        context,
        message: state.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesPage(
      pageContent:
          BlocListener<FavoriteInstrumentsCubit, FavoriteInstrumentsState>(
        listener: blocListner,
        child: BlocBuilder<FavoriteInstrumentsCubit, FavoriteInstrumentsState>(
          builder: (context, state) {
            if (state is InitialFavoriteInstrumentsState) {
              return const SizedBox.shrink();
            } else if (state is LoadingFavoriteInstrumentsState) {
              return const LoadingIndicator();
            } else if (state is EmptyFavoriteInstrumentsState) {
              return const EmptyFavoritesView();
            } else if (state is LoadedFavoriteInstrumentsState) {
              return FavoriteInstrumentsView(
                list: state.list,
              );
            } else if (state is ErrorFavoriteInstrumentsState) {
              return const SizedBox.shrink();
            }
            return const UnknowedfBlocStateView();
          },
        ),
      ),
    );
  }
}
