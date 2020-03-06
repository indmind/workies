import 'package:flutter/material.dart';

class WorkItem extends StatelessWidget {
  final String message;

  WorkItem({this.message});

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
