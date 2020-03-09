import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workies/models/work.dart';
import 'package:workies/services/db.dart';
import 'package:workies/widgets/disappear.dart';

import 'package:workies/widgets/work_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<> works = List<>;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            _buildStreamBuilder(),
            Disappear(
              position: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Work>> _buildStreamBuilder() {
    final db = Provider.of<DatabaseService>(context);

    return StreamBuilder<List<Work>>(
      stream: db.streamAllWorks(),
      builder: (BuildContext context, AsyncSnapshot<List<Work>> works) {
        if (works.hasError) return Text("Error: ${works.error}");

        print("on data change");

        switch (works.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return ListView.builder(
              padding: EdgeInsets.only(
                bottom: 30,
              ),
              itemCount: !works.hasData ? 1 : works.data.length + 20 + 1,
              itemBuilder: (_, index) {
                if (index == 0) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                        bottom: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Text(
                        "Your Works...",
                        style: Theme.of(context).textTheme.title.merge(
                              TextStyle(
                                fontSize: 35,
                              ),
                            ),
                      ),
                    ),
                  );
                }

                index -= 1;

                return WorkItem(
                  work: works.data[1],
                );
              },
            );
        }
      },
    );
  }
}
