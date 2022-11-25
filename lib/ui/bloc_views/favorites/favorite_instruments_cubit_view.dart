import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../logic/models/instrument_list.dart';
import '../../blocs/favorites/favorite_instruments_cubit/favorite_instruments_cubit.dart';
import '../../blocs/favorites/favorite_instruments_cubit/favorite_instruments_state.dart';
import '../../components/favorites/empty_favorites_view.dart';
import '../../components/favorites/favorite_instrument_card.dart';
import '../../components/list_builders/instrument_list_builder.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/unknowed_bloc_state_view.dart';
import '../../components/wrappers/dismissible_wrapper.dart';
import '../../pages/home/favorites_page.dart';

class FavoriteInstrumentsCubitView extends StatelessWidget {
  const FavoriteInstrumentsCubitView({super.key});

  void blocListner(BuildContext context, FavoriteInstrumentsState state) {
    if (state is! InitialFavoriteInstrumentsState &&
        state is! LoadingFavoriteInstrumentsState) {
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
    return BlocListener<FavoriteInstrumentsCubit, FavoriteInstrumentsState>(
      listener: blocListner,
      child: BlocBuilder<FavoriteInstrumentsCubit, FavoriteInstrumentsState>(
        builder: (context, state) {
          return FavoritesPage(
            isRefresning: state is RefreshingFavoriteInstrumentsState,
            children: [
              if (state is InitialFavoriteInstrumentsState)
                const SizedBox.shrink()
              else if (state is LoadingFavoriteInstrumentsState)
                const LoadingIndicator()
              else if (state is EmptyFavoriteInstrumentsState)
                const EmptyFavoritesView()
              else if (state is LoadedFavoriteInstrumentsState)
                ..._buildList(state.list, context)
              else if (state is ErrorFavoriteInstrumentsState)
                const SizedBox.shrink()
              else if (state is RefreshingFavoriteInstrumentsState)
                ..._buildList(state.list, context)
              else
                const UnknowedfBlocStateView()
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildList(InstrumentList list, BuildContext context) {
    return InstrumentListBuilder(
      instrumentList: list,
      itemBuilder: (instrument) {
        return DismissibleWrapper(
          uniqKey: instrument.figi,
          onRightSwipe: () => BlocProvider.of<FavoriteInstrumentsCubit>(context)
              .delete(instrument),
          child: FavoriteInstrumentCard(
            instrument: instrument,
          ),
        );
      },
    ).build();
  }
}
