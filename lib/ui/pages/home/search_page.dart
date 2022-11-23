import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/recent_search_items_cubit/recent_search_items_cubit.dart';
import '../../blocs/search_page_content_cubit/search_page_content_cubit.dart';
import '../../components/form_text_field.dart';
import '../../components/page_wrapper.dart';

class SearchPage extends StatefulWidget {
  final TextEditingController searchTextControlller;
  final FocusNode searchFocusNode;
  final Widget pageContent;

  const SearchPage({
    super.key,
    required this.searchTextControlller,
    required this.searchFocusNode,
    required this.pageContent,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _startSearching() {
    BlocProvider.of<SearchPageContentCubit>(context).startSearching();
  }

  void _saveSearchingText(String text) {
    BlocProvider.of<RecentSearchItemsCubit>(context).add(text);
  }

  void _stopSearching() {
    BlocProvider.of<SearchPageContentCubit>(context).stopSearching();
  }

  void _unfocusSearchField() {
    widget.searchFocusNode.unfocus();
  }

  void _submitSearchField(String? text) {
    if (text?.isNotEmpty ?? false) {
      _startSearching();
      _saveSearchingText(text!);
    }
  }

  void _onChangeText(String? value) {
    if (value?.isEmpty ?? true) {
      _stopSearching();
      _unfocusSearchField();
    }
  }

  void _search() {
    final text = widget.searchTextControlller.text;
    if (text.isNotEmpty) {
      _startSearching();
      _saveSearchingText(text);
      _unfocusSearchField();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Поиск',
      children: [
        FormTextField(
          label: 'Поиск',
          controller: widget.searchTextControlller,
          focusNode: widget.searchFocusNode,
          keyboardType: TextInputType.text,
          onFieldSubmitted: _submitSearchField,
          onChange: _onChangeText,
          suffixIcon: IconButton(
            onPressed: _search,
            icon: const Icon(Icons.search),
          ),
        ),
        widget.pageContent,
      ],
    );
  }
}
