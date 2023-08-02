import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/instrument.dart';
import '../../../logic/models/instrument_list.dart';
import '../../blocs/favorites/favorite_instruments_cubit/favorite_instruments_cubit.dart';
import '../../blocs/search/search_instruments_cubit/search_instruments_cubit.dart';
import '../../blocs/search/search_instruments_cubit/search_instruments_state.dart';
import '../../components/list_builders/instrument_list_builder.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/search_page/empty_search_result.dart';
import '../../components/search_page/search_result_card.dart';
import '../../components/unknowed_bloc_state_view.dart';
import '../../pages/home/search_page.dart';

class SearchInstrumentsCubitView extends StatefulWidget {
  final TextEditingController searchTextController;
  final FocusNode searchFocusNode;
  const SearchInstrumentsCubitView({
    super.key,
    required this.searchTextController,
    required this.searchFocusNode,
  });

  @override
  State<SearchInstrumentsCubitView> createState() =>
      _SearchInstrumentsCubitViewState();
}

class _SearchInstrumentsCubitViewState
    extends State<SearchInstrumentsCubitView> {
  void listner(BuildContext context, SearchInstrumentsState state) {
    if (state is ErrorSearchInstrumentsState) {
      ErrorModal.show(context, message: state.message);
    }
  }

  void changeFavorites(Instrument instrument, {required bool isSelected}) {
    if (isSelected) {
      BlocProvider.of<FavoriteInstrumentsCubit>(context)
          .delete(instrument, needUpdateList: true);
    } else {
      BlocProvider.of<FavoriteInstrumentsCubit>(context).add(instrument);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchInstrumentsCubit, SearchInstrumentsState>(
      listener: listner,
      child: BlocBuilder<SearchInstrumentsCubit, SearchInstrumentsState>(
        builder: (context, state) {
          return SearchPage(
            searchTextController: widget.searchTextController,
            searchFocusNode: widget.searchFocusNode,
            children: [
              if (state is StoppedSearchInstrumentsState)
                const SizedBox.shrink()
              else if (state is LoadingSearchInstrumentsState)
                const LoadingIndicator()
              else if (state is EmptySearchInstrumentsState)
                EmptySearchResultView(query: state.query)
              else if (state is LoadedSearchInstrumentsState)
                ..._buildList(state.instrumentList)
              else if (state is ErrorSearchInstrumentsState)
                const SizedBox.shrink()
              else
                const UnknowedfBlocStateView()
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildList(InstrumentList list) {
    return InstrumentListBuilder(
      instrumentList: list,
      itemBuilder: (instrument) {
        return SearchResultCard(
          instrument: instrument,
          onPressFavoriteIcon: (isSelected) =>
              changeFavorites(instrument, isSelected: isSelected),
        );
      },
    ).build();
  }
}
