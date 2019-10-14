import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
@override
SuccessState createState() => new SuccessState();
}

class SuccessState extends State<Success> {



  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.green,
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Succes !!!", style: TextStyle(color: Colors.black),),
        ],
      ))
    );
  }
}