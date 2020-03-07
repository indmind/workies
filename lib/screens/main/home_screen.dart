import 'package:flutter/material.dart';
import 'package:workies/models/work.dart';
import 'package:workies/services/db.dart';

import 'package:workies/widgets/work_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<> works = List<>;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildStreamBuilder());
  }

  StreamBuilder<List<Work>> _buildStreamBuilder() {
    return StreamBuilder<List<Work>>(
      stream: DatabaseService().streamAllWorks(),
      builder: (BuildContext context, AsyncSnapshot<List<Work>> works) {
        if (works.hasError) return Text("Error: ${works.error}");

        switch (works.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return ListView(
              children: works.data
                  .map(
                    (work) => WorkItem(work: work),
                  )
                  .toList(),
            );
        }
      },
    );
  }
}
