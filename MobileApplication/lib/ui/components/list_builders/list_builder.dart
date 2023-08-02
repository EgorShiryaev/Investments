import 'package:flutter/material.dart';

import '../subtitle.dart';

class ListBuilder<T> {
  final String listTitle;
  final List<T> list;
  final Widget Function(T) itemBuilder;

  ListBuilder({
    required this.listTitle,
    required this.list,
    required this.itemBuilder,
  });

  List<Widget> build() {
    return [
      Subtitle(text: listTitle),
      ...list.map(itemBuilder),
    ];
  }
}
