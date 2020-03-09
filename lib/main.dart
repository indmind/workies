import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:workies/screens/main/main_screen.dart';
import 'package:workies/services/db.dart';

const Color primaryColor = Color(0xFF2d3436);

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  return runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
      ],
      child: MaterialApp(
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
      ),
    ),
  );
}
