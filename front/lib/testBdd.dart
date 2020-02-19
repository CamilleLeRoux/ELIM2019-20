import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'package:front/kMeans.dart';

class TestBdd extends StatelessWidget {

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['idUser'].toString()),
      subtitle: Text(document['score'].toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection('sentenceTest').snapshots(),
              //print an integer every 2secs, 10 times
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading..");
                }
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return _buildList(context, snapshot.data.documents[index]);
                  },
                );
              },
            ),
          ),
          FlatButton(
            color: PrimaryAssentColor,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              add();
            },
            child: Text(
              "Test add",
            ),
          ),
        ],
      ),
    );
  }

  void add() {
    //kMeans().kMeansScore(3);

  }
}