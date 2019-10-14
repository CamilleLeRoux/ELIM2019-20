import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Failure extends StatefulWidget {
  @override
  FailureState createState() => new FailureState();
}

class FailureState extends State<Failure> {



  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.red,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Failure !!!", style: TextStyle(color: Colors.black),),
          ],
        ))
    );
  }
}