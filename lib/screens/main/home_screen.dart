import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:workies/models/work.dart';

import 'package:workies/widgets/work_item.dart';

class HomeScreen extends StatefulWidget {
  HttpsCallable allWorks =
      CloudFunctions.instance.getHttpsCallable(functionName: "allWorks");

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
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "This is Home",
            style: TextStyle(fontSize: 20),
          ),
          buildStreamBuilder(),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("works").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");

        print("con state ${snapshot.connectionState}");

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return Column(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                print(document);

                String message = document["message"];

                return WorkItem(message: message);
              }).toList(),
            );
        }
      },
    );
  }
}
