import 'package:flutter/material.dart';
import 'package:front/failure.dart';
import 'dart:async';

import 'package:front/succes.dart';

class Sentence extends StatefulWidget {
  @override
  SentenceFormState createState(){
    return SentenceFormState();
  }

}

class SentenceFormState extends State<Sentence>{

  final controller = TextEditingController();
  Timer _timer;
  int _start = 15;
  String sentence= "les patates fluo";

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start <= 0) {
            timer.cancel();
            if(controller.text == sentence){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => Success()
                  )
              );
            }
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => Failure()
                )
            );
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Test de la phrase")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin : EdgeInsets.only( bottom: 270.0, top: 25),
                child: Text("$_start", style: TextStyle(fontSize: 40),)
            ),
            Text(sentence, style: TextStyle(fontSize: 30)),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Container(
              margin : EdgeInsets.only( bottom: 30.0),
              child: TextFormField(
                controller: controller,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: 'Rentrez ici la phrase ci-dessus'
                ),
                onFieldSubmitted: (term) {
                  verif();
                },
                textInputAction: TextInputAction.go,
                onTap: startTimer,
              ),
            )
          ],
        ),
      ),
    );
  }

  void verif(){
    if(controller.text == sentence){
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Success()
          )
      );
    }else{
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Failure()
          )
      );
    }
  }
}