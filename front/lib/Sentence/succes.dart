import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/stateQuizz.dart';

class Success extends StatelessWidget {

  final int score;
  Success({Key key, @required this.score}) : super();

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
          color: Colors.green,
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Succes !!!", style: TextStyle(color: Colors.black),),
              Text(score.toString() + "/4", style: TextStyle(color: Colors.black),),
            ],
          ))
      ),
    );
  }
}