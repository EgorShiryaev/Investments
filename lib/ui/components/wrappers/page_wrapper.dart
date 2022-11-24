import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../page_title.dart';
import '../separator.dart';

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

  static const appBarHeight = 39.0;

  Future<void> defaultPullToRefresh() {
    return Future.delayed(Duration.zero);
  }

  Widget _wrapPadding(Widget item) {
    return Padding(
      padding: AppTheme.pagePadding,
      child: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _wrapPadding(
                    PageTitle(
                      title: pageTitle,
                      subtitle: pageSubtitle,
                      action: pageTitleAction,
                    ),
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isEven) {
                    return const Separator();
                  }
                  final childrenIndex = ((index - 1) / 2).ceil();
                  return _wrapPadding(children[childrenIndex]);
                },
                childCount: children.length * 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
