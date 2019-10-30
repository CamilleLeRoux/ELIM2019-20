import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/stateQuizz.dart';

class Failure extends StatelessWidget {

  final int score;
  Failure({Key key, @required this.score}) : super();

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => StateQuizz().getNextTest()
            )
        );
      },
      child: Container(
          color: Colors.red,
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Failure !!!", style: TextStyle(color: Colors.black),),
              Text(score.toString() + "/4", style: TextStyle(color: Colors.black),),
            ],
          ))
      ),
    );
  }
}