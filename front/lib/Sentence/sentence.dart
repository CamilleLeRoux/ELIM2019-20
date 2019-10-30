import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' show Random;

import 'package:front/Sentence/succes.dart';
import 'package:front/colors.dart';

import 'package:front/Sentence/failure.dart';

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
  var word1 = ["les", "la", "le", "des", "une", "un"];
  var word2 = ["patates", "asperges", "avions", "pedoncule", "casquette", "bidulle"];
  var word3 = ["sont", "vont", "mange", "volent", "gratte", "vendent"];
  var word4 = ["fluo", "bananes", "pizzas", "livre", "Amerique", "flutter"];
  var choose = [];
  String sentence = "";

  @override
  void initState() {
    var randomizer = new Random();
    int rand1 = randomizer.nextInt(5);
    int rand2 = randomizer.nextInt(5);
    int rand3 = randomizer.nextInt(5);
    int rand4 = randomizer.nextInt(5);
    choose.add(rand1);
    choose.add(rand2);
    choose.add(rand3);
    choose.add(rand4);
    sentence = word1[rand1] + " " + word2[rand2] + " " + word3[rand3] + " " + word4[rand4];
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start <= 0) {
            verif();
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

  Future<bool> _willPopCallback() async {
    return false;
  }

  Widget build(BuildContext context) {

    return new WillPopScope(child: Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
          title: Text("Test de la phrase"),
          backgroundColor: PrimaryColor,
          automaticallyImplyLeading: false
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin : EdgeInsets.only( bottom: 200.0, top: 25),
                child: Text("$_start",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white)
                )
            ),
            Text(sentence, style: TextStyle(fontSize: 30, color: Colors.white)),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Container(
              margin : EdgeInsets.only( bottom: 30.0),
              child: TextFormField(
                controller: controller,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: 'Rentrez ici la phrase ci-dessus',
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    )
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
    ), onWillPop: _willPopCallback);
  }

  void verif(){
    int score = 0;
    var w = controller.text.split(" ");
    if(w[0] == word1[choose[0]]) ++score;
    if(w[1] == word2[choose[1]]) ++score;
    if(w[2] == word3[choose[2]]) ++score;
    if(w[3] == word4[choose[3]]) ++score;
    print("Score : " + score.toString());

    if(score == 4){
      _timer.cancel();
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Success(score: score,)
          )
      );
    }else{
      _timer.cancel();
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Failure(score: score,)
          )
      );
    }
  }
}