import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'activity_screen.dart';
import 'books_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey _bottomNavigationKey = GlobalKey();

  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = new TabController(length: 3, vsync: this);

    controller.addListener(_tabChangeListener);
  }

  _tabChangeListener() {
    print("Index: ${controller.index}");

    final CurvedNavigationBarState navbarState =
        _bottomNavigationKey.currentState;

    navbarState.setPage(controller.index);
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Home Screen",
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[HomeScreen(), ActivityScreen(), BooksScreen()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        animationDuration: Duration(seconds: 1),
        animationCurve: Curves.elasticOut,
        height: 60,
        color: primaryColor,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.hourglass_empty, color: Colors.white),
          Icon(Icons.group_work, color: Colors.white),
          Icon(Icons.import_contacts, color: Colors.white)
        ],
        onTap: (index) => controller.animateTo(index),
      ),
    );
  }
}
