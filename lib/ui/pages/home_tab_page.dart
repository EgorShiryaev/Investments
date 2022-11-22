import 'package:flutter/material.dart';

import 'home/favorites_page.dart';
import 'home/profile_page.dart';
import 'home/search_page.dart';

class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key});

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  int selectedIndex = 0;

  void changeSelectedIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        FavoritesPage(),
        SearchPage(),
        ProfilePage(),
      ].elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeSelectedIndex,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outlined),
            label: "Избранные",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Поиск",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
        ],
      ),
    );
  }
}
