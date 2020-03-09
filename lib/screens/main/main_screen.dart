import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workies/providers/counter_provider.dart';
import 'package:workies/screens/main/facedetec_screen.dart';

import 'activity_screen.dart';
import 'ar_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey _bottomNavigationKey = GlobalKey();

  TabController controller;

  final ValueNotifier<String> _title = ValueNotifier<String>("Home");

  @override
  void initState() {
    super.initState();

    controller = new TabController(length: 4, vsync: this);

    controller.addListener(_tabChangeListener);
  }

  _tabChangeListener() {
    print("Index: ${controller.index}");

    final CurvedNavigationBarState navbarState =
        _bottomNavigationKey.currentState;

    navbarState.setPage(controller.index);

    switch (controller.index) {
      case 0:
        return _title.value = "Home";
      case 1:
        return _title.value = "Faten";
      case 2:
        return _title.value = "Face Detect";
      default:
        return _title.value = "Ar";
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider<Counter>(
      create: (_) => Counter(),
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: ValueListenableBuilder<String>(
            builder: (context, title, child) {
              return Text(
                title,
              );
            },
            valueListenable: _title,
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: <Widget>[
            HomeScreen(),
            ActivityScreen(),
            FaceDetectScreen(),
            ArScreen()
          ],
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
            Icon(Icons.face, color: Colors.white),
            Icon(Icons.import_contacts, color: Colors.white)
          ],
          onTap: (index) => controller.animateTo(index),
        ),
      ),
    );
  }
}
