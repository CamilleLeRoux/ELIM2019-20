import 'package:flutter/material.dart';

import 'package:front/Mouvement/CountMouvement.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';
import 'dart:async';

import 'package:front/colors.dart';
import 'package:front/stateQuizz.dart';

class Mouvement extends StatefulWidget{
  final int counterPage;

  Mouvement(this.counterPage, {Key key}): super(key: key);
  @override
  MouvementFormState createState(){
    return MouvementFormState();
  }
}

class MouvementFormState extends State<Mouvement>{
  int _movementNB;
  var url = "assets/";
  int _start = 2;
  bool _success = false;

  //Accelerometre variables
  int diff = 3;
  bool first = true;
  var valueAcc = {
    "x": 0.0,
    "y": 0.0,
    "z": 0.0,
  };

  StreamSubscription accel;


  @override
  void initState(){
    super.initState();
    chooseMouvement();
    startTimer();
    accel = accelerometerEvents.listen((AccelerometerEvent event) {
      if(first){
        valueAcc["x"] = double.parse(event.x.toString());
        valueAcc["y"] = double.parse(event.y.toString());
        valueAcc["z"] = double.parse(event.z.toString());
        print(valueAcc);
        first = false;
      }

      print(double.parse(event.y.toString()));

      switch(_movementNB){
        case 1:{
          if((double.parse(event.z.toString()) > valueAcc["z"] + diff)){
            print("detecté: ");
            print(double.parse(event.z.toString()));
            _success = true;
            print("haut");
          }
        }break;
        case 2:{
          if(double.parse(event.z.toString()) + diff < valueAcc["z"] ){
            _success = true;
            print("bas");
          }
        }break;
        case 3:{
          if(double.parse(event.y.toString()) + 0.3  < valueAcc["y"] ){
            _success = true;
            print("droite");
          }
        }break;
        case 4:{
          if(double.parse(event.y.toString())  > valueAcc["y"] + 0.3){
            _success = true;
            print("gauche");
          }
        }break;
      }
    });
  }
  Future<bool> _willPopCallback() async {
    return false;
  }
  Widget build(BuildContext context){
    return new WillPopScope(
        child: Scaffold(
          backgroundColor: PrimaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage(url),
                    width: 400.0,
                    height: 400.0,
                    fit: BoxFit.cover
                )
              ],
            ),
          ),
        ),
    onWillPop: _willPopCallback);
  }
  void chooseMouvement(){
    final _random = new Random();
    _movementNB = 3 + _random.nextInt(4 - 2);
    print(_movementNB);
    url += _movementNB.toString() + ".png";
  }


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    var _timer = new Timer.periodic(
      oneSec, (Timer timer) => setState(() {
        if (_start <= 0) {
          timer.cancel();
          accel.cancel();

          if(_success){
            StateQuizz().score += 1;
          }

          if(widget.counterPage == 3){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => StateQuizz().getNextTest("")
                )
            );
          }
          if (widget.counterPage < 3) {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => CountMouvement(widget.counterPage)
                )
            );
          }
        }
         else {
          _start = _start - 1;
        }
      },
    ),
    );
  }


}

