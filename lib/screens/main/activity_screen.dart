import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workies/providers/counter_provider.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Counter counter = Provider.of<Counter>(context, listen: false);

    print("rendered");

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<Counter>(builder: (_, Counter counter, __) {
            print("render counter");
            return Text("${counter.value}", style: TextStyle(fontSize: 20));
          }),
          Consumer<Counter>(
            builder: (_, Counter counter, __) {
              print("render weight");
              return Text("${counter.weight}", style: TextStyle(fontSize: 20));
            },
          ),
          FlatButton(
            onPressed: () {
              counter.increment();
              counter.fatten();
            },
            child: Text("increment"),
          )
        ],
      ),
    );
  }
}
