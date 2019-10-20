import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:front/failure.dart';
import 'package:front/succes.dart';
import 'package:front/colors.dart';

class Mouvement extends StatefulWidget{
  @override
  MouvementFormState createState(){
    return MouvementFormState();
  }
}

class MouvementFormState extends State<Mouvement>{
  int _movementNB;
  var url = "assets/";
  int _start = 15;
  Timer _timer;
  bool _success = false;

  //Accelerometre variables
  int diff = 50;
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
        first = false;
      }

      switch(_movementNB){
        case 1:{
          if(double.parse(event.z.toString()) > valueAcc["z"] + diff){
            _success = true;
            print("haut");
          }
        }break;
        case 2:{
          if(double.parse(event.z.toString()) > valueAcc["z"] + diff){
            _success = true;
            print("bas");
          }
        }break;
        case 3:{
          if(double.parse(event.y.toString()) > valueAcc["y"] + diff){
            _success = true;
            print("droite");
          }
        }break;
        case 4:{
          if(double.parse(event.y.toString()) < valueAcc["y"] + diff){
            _success = true;
            print("gauche");
          }
        }break;
      }
    });
  }

  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
        title: Text("Test du mouvement"),
        backgroundColor: PrimaryColor,
      ),
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
    );
  }

  void chooseMouvement(){
    final _random = new Random();
    print(1 + _random.nextInt(4 - 1));
    _movementNB = 1 + _random.nextInt(4 - 1);
    url += _movementNB.toString() + ".png";
  }


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) => setState(() {
        if (_start <= 0) {
          timer.cancel();
          accel.cancel();
          if(_success) {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => Success()
                )
            );
          }
          else {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => Failure()
                )
            );
          }
        } else {
          _start = _start - 1;
        }
      },
    ),
    );
  }


}

