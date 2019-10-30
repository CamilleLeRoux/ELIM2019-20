import 'dart:async';

import 'package:flutter/material.dart';
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

  StreamSubscription accel;

  AlignmentDirectional ironManAlignment = AlignmentDirectional(0.0, 1);

  @override
  void initState(){
    super.initState();
    accel = accelerometerEvents.listen((AccelerometerEvent event) {
      if(first){
        valueAcc["x"] = double.parse(event.x.toString());
        valueAcc["y"] = double.parse(event.y.toString());
        valueAcc["z"] = double.parse(event.z.toString());
        print(valueAcc);
        first = false;
      }

      print(double.parse(event.y.toString()));

      if(double.parse(event.y.toString()) + 0.3  < valueAcc["y"] ){
        print("droite");
        droite();
        new Future.delayed(const Duration(seconds: 1));
        first = true;
      }

      if(double.parse(event.y.toString())  > valueAcc["y"] + 0.3){
        print("gauche");
        gauche();
        new Future.delayed(const Duration(seconds: 1));
        first = true;
      }
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
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 3),
            alignment: ironManAlignment,
            child: Container(
              height: 150,
              width: 50,
              child: Image.asset('assets/drunk.png'),
            ),
          ),
          Row(
            children: <Widget>[
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    move();
                  },
                  child: Text('Go'),
                  color: Colors.red,
                  textColor: Colors.yellowAccent,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    gauche();
                  },
                  child: Text('gauche'),
                  color: Colors.red,
                  textColor: Colors.yellowAccent,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    droite();
                  },
                  child: Text('droite'),
                  color: Colors.red,
                  textColor: Colors.yellowAccent,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  void move() {
    setState(() {
      ironManAlignment = AlignmentDirectional(0.0,-1);
    });
  }

  void droite() {
    setState(() {
      ironManAlignment = AlignmentDirectional(1.0,0.0);
    });
  }

  void gauche() {
    setState(() {
      ironManAlignment = AlignmentDirectional(-1.0,0.0);
    });
  }

}