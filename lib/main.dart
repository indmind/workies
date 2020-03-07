import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:workies/screens/main/main_screen.dart';

const Color primaryColor = Color(0xFF2d3436);

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: null,
          )
        ],
        child: myApp(),
      ),
    );

MaterialApp myApp() {
  return MaterialApp(
    title: 'Workies',
    theme: ThemeData(
      primaryColor: primaryColor,
      textTheme: TextTheme(
        title: TextStyle(
          color: primaryColor,
        ),
        body1: TextStyle(
          color: primaryColor,
        ),
      ),
    ),
    home: MainScreen(),
  );
}
