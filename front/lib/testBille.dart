import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/stateQuizz.dart';

import 'colors.dart';

class TestBille extends StatefulWidget {
  final int counterPage;

  TestBille(this.counterPage, {Key key}): super(key: key);

  @override
  TestBilleState createState() => TestBilleState();
}

class TestBilleState extends State<TestBille> {

  Timer _timer;
  int _start = 10;

  int last = 0;
  int points = 0;
  int touch = 0;

  var colors = [];

  @override
  void initState() {
    super.initState();
    startTimer();
    for(int i = 0; i < 16; ++i){
      colors.add(Colors.white);
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  moveBille());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PrimaryColor,
        appBar: AppBar(
            title: Text("Test de la Bille"),
            backgroundColor: PrimaryColor,
            automaticallyImplyLeading: false
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[0],), onTap: (){ verif(0);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[1],), onTap: (){ verif(1);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[2],), onTap: (){ verif(2);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[3],), onTap: (){ verif(3);},),
                ],
              ),
              Row(
                children: <Widget>[
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[4],), onTap: (){ verif(4);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[5],), onTap: (){ verif(5);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[6],), onTap: (){ verif(6);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[7],), onTap: (){ verif(7);},),
                ],
              ),
              Row(
                children: <Widget>[
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[8],), onTap: (){ verif(8);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[9],), onTap: (){ verif(9);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[10],), onTap: (){ verif(10);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[11],), onTap: (){ verif(11);},),
                ],
              ),
              Row(
                children: <Widget>[
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[12],), onTap: (){ verif(12);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[13],), onTap: (){ verif(13);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[14],), onTap: (){ verif(14);},),
                  InkWell(child: Icon(Icons.cancel, size: 90, color: colors[15],), onTap: (){ verif(15);},),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text("$_start",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white)
                ),
              )
            ],
          ),
        )
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start <= 0) {
            _timer.cancel();
            if(points > 10){
              StateQuizz().score += 1;
              print("Victory !");
            }
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => StateQuizz().getNextTest("")
                )
            );
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void moveBille(){
    colors[touch] = Colors.white;
    colors[last] = Colors.white;
    final _random = new Random();
    last = _random.nextInt(16);
    setState(() {
      colors[last] = Colors.green;
    });
  }

  void verif(int i){
    print(i);
    print(last);
    touch = i;
    if (i == last){
      ++points;
      moveBille();
    }else{
      setState(() {
        colors[touch] = Colors.red;
      });
      --points;
      print(colors[touch]);
      print(colors[i]);
      print("bad");
      sleep(new Duration(seconds: 1));
      print("bad bad");
      moveBille();
    }
  }
}
