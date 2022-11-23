import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/search/search_instruments_cubit/search_instruments_cubit.dart';
import '../../blocs/search/search_instruments_cubit/search_instruments_state.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/search_page/empty_search_result.dart';
import '../../components/search_page/search_result_instrument_list.dart';
import '../../components/unknowed_bloc_state_view.dart';

class SearchInstrumentsCubitView extends StatelessWidget {
  const SearchInstrumentsCubitView({super.key});

  void listner(BuildContext context, SearchInstrumentsState state) {
    if (state is ErrorSearchInstrumentsState) {
      ErrorModal.show(context, message: state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchInstrumentsCubit, SearchInstrumentsState>(
      listener: listner,
      child: BlocBuilder<SearchInstrumentsCubit, SearchInstrumentsState>(
        builder: (context, state) {
          if (state is StoppedSearchInstrumentsState) {
            return const SizedBox.shrink();
          } else if (state is LoadingSearchInstrumentsState) {
            return const LoadingIndicator();
          } else if (state is EmptySearchInstrumentsState) {
            return EmptySearchResultView(query: state.query);
          } else if (state is LoadedSearchInstrumentsState) {
            return SearchResultInstrumentList(
              list: state.instrumentList,
            );
          } else if (state is ErrorSearchInstrumentsState) {
            return const SizedBox.shrink();
          }
          return const UnknowedfBlocStateView();
        },
      ),
    );
  }
}
