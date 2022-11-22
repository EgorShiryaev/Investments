import 'package:flutter/material.dart';

import 'page_title.dart';
import 'separator.dart';

class PageWrapper extends StatelessWidget {
  final String pageTitle;
  final String? pageSubtitle;
  final List<Widget> children;
  final Widget? pageTitleAction;

  const PageWrapper({
    super.key,
    required this.children,
    required this.pageTitle,
    this.pageSubtitle,
    this.pageTitleAction,
  });

  static const separatorHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(
                      title: pageTitle,
                      subtitle: pageSubtitle,
                      titleAction: pageTitleAction,
                    ),
                    ...List.generate(2 * children.length, (index) {
                      if (index.isEven) {
                        return const Separator();
                      }
                      final childrenIndex = ((index - 1) / 2).ceil();
                      return children[childrenIndex];
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
