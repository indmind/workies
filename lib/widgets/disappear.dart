import 'package:flutter/material.dart';

class Disappear extends StatelessWidget {
  final Alignment position;

  const Disappear({this.position});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: position,
      child: SizedBox(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.white, Colors.white.withOpacity(0.0)],
              begin: position == Alignment.topCenter
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              end: position != Alignment.topCenter
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
