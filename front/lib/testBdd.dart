import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class TestBdd extends StatelessWidget {

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['name']),
      subtitle: Text(document['temps'].toString()),
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
              stream: Firestore.instance.collection('test').snapshots(),
              //print an integer every 2secs, 10 times
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading..");
                }
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: 2,
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
    Firestore.instance.collection('sentenceTest').add({"score": 12, "idUser": "yolo"});
  }
}