import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/index.dart';
import '../../components/form_text_field.dart';
import '../../components/wrappers/page_wrapper.dart';

class SearchPage extends StatefulWidget {
  final TextEditingController searchTextController;
  final FocusNode searchFocusNode;
  final List<Widget> children;

  const SearchPage({
    super.key,
    required this.searchTextController,
    required this.searchFocusNode,
    required this.children,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _startSearching(String text) {
    BlocProvider.of<SearchPageContentCubit>(context).startSearching();
    BlocProvider.of<SearchInstrumentsCubit>(context).search(text);
  }

  void _saveSearchingText(String text) {
    BlocProvider.of<RecentSearchListCubit>(context).add(text);
  }

  void _stopSearching() {
    BlocProvider.of<SearchPageContentCubit>(context).stopSearching();
    BlocProvider.of<SearchInstrumentsCubit>(context).stopSearch();
  }

  void _unfocusSearchField() {
    widget.searchFocusNode.unfocus();
  }

  void _submitSearchField(String? text) {
    if (text?.isNotEmpty ?? false) {
      _startSearching(text!);
      _saveSearchingText(text);
    }
  }

  void _onChangeText(String? value) {
    if (value?.isEmpty ?? true) {
      _stopSearching();
      _unfocusSearchField();
    }
  }

  void _clear() {
    widget.searchTextController.text = '';
    _stopSearching();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Поиск',
      children: [
        FormTextField(
          label: 'Поиск',
          controller: widget.searchTextController,
          focusNode: widget.searchFocusNode,
          keyboardType: TextInputType.text,
          onFieldSubmitted: _submitSearchField,
          onChange: _onChangeText,
          suffixIcon: IconButton(
            onPressed: _clear,
            icon: const Icon(Icons.clear),
          ),
        ),
        ...widget.children,
      ],
    );
  }
}
