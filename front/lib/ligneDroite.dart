import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front/stateQuizz.dart';
import 'package:sensors/sensors.dart';

import 'colors.dart';

class LigneDroite extends StatefulWidget {
  final int counterPage;

  LigneDroite(this.counterPage, {Key key}): super(key: key);
  @override
  LigneDroiteState createState() => LigneDroiteState();
}

class LigneDroiteState extends State<LigneDroite> with TickerProviderStateMixin {

  int diff = 3;
  bool first = true;

  var valueAcc = {
    "x": 0.0,
    "y": 0.0,
    "z": 0.0,
  };

  int badpoints = 0;
  StreamSubscription accel;
  double angle = 0.0;

  Animation<Offset> _arrowAnimation;
  AnimationController _arrowAnimationController;

  @override
  void initState(){
    super.initState();

    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _arrowAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -4.2))
            .animate(_arrowAnimationController);

    _arrowAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        if(badpoints < 5){
          StateQuizz().score += 1;
        }
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => StateQuizz().getNextTest("")
            )
        );
      }
    });

    accel = accelerometerEvents.listen((AccelerometerEvent event) {
      if(first){
        valueAcc["x"] = double.parse(event.x.toString());
        valueAcc["y"] = double.parse(event.y.toString());
        valueAcc["z"] = double.parse(event.z.toString());
        //print(valueAcc);
        first = false;
      }

      //print(double.parse(event.y.toString()));

      if(double.parse(event.y.toString()) + 0.5  < valueAcc["y"] ){
        print("droite");
        right();
        new Future.delayed(const Duration(seconds: 1));
        first = true;
      }

      if(double.parse(event.y.toString())  > valueAcc["y"] + 0.5){
        print("gauche");
        left();
        new Future.delayed(const Duration(seconds: 1));
        first = true;
      }

      WidgetsBinding.instance
          .addPostFrameCallback((_) => move());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
          title: Text("Test de la ligne"),
          backgroundColor: PrimaryColor,
          automaticallyImplyLeading: false
      ),
      body: Center(
          child:
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _arrowAnimation,
                  child: Transform.rotate(
                    angle: angle,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 100.0,
                      color: Colors.black,
                    ),
                  ),
            ),
              ),
      )
    );
  }

  void right(){
    setState(() {
      double newAngle = angle + 0.5;
      if (newAngle <= pi/2) {
        angle = newAngle;
      }else{
        angle = pi/2;
      }

      if (angle > pi/4){
        ++badpoints;
      }
      print(badpoints);
    });
  }

  void left(){
    setState(() {
      double newAngle = angle - 0.5;
      if (newAngle >= -pi/2){
        angle = newAngle;
      }else{
        angle = -pi/2;
      }

      if (angle < -pi/4){
        ++badpoints;
      }
      print(badpoints);
    });
  }

  void move(){
    _arrowAnimationController.forward();
  }



}