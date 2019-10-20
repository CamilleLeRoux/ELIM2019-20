import 'package:flutter/material.dart';
import 'dart:async';
import 'package:front/Mouvement/mouvement.dart';
import 'dart:developer' as developer;
import 'package:front/colors.dart';

class CountMouvement extends StatefulWidget {
  @override
  CountMouvementFormState createState(){
    return CountMouvementFormState();
  }
}

class CountMouvementFormState extends State<CountMouvement>{

  Timer _timer;
  int _start = 2;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
        title: Text("Test de la phrase"),
        backgroundColor: PrimaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Prépare toi à effectuer un mouvement!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Container(
                margin : EdgeInsets.only( bottom: 270.0, top: 25),
                child: Text("$_start", style: TextStyle(fontSize: 40, color:
                Colors.white),)
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) => setState(() {
        if (_start <= 0) {
          timer.cancel();
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => Mouvement()
              )
          );
        } else {
          _start = _start - 1;
        }
      },
      ),
    );
  }



}