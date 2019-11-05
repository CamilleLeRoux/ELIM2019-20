import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' show Random;

import 'package:front/Sentence/succes.dart';
import 'package:front/colors.dart';

import 'package:front/Sentence/failure.dart';
import 'package:front/BDD/DatabaseService.dart';

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
            _timer.cancel();
            this.verif();
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

    return new WillPopScope(
        child: new Scaffold(
          backgroundColor: PrimaryColor,
          appBar: new AppBar(
            title: new Text("Test de la phrase"),
            backgroundColor: PrimaryColor,
            automaticallyImplyLeading: false
          ),

          body: new Center(
            child: new SingleChildScrollView(
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: new Column(children: <Widget>[
                  new Container(
                      child: Text("$_start",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white)
                      )
                  ),
                  new Text(sentence, style: TextStyle(fontSize: 20, color:
                  Colors.white)),
                  new Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  new Container(
                    child: new TextFormField(
                      controller: controller,
                      autocorrect: false,
                      decoration: new InputDecoration(
                          labelText: 'Rentrez ici la phrase ci-dessus',
                          labelStyle: new TextStyle(
                              color: Colors.white
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
                          focusedBorder: new OutlineInputBorder(
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
                  ),

                  ],
                ),
              ),
            ),
          ),

        ), onWillPop: _willPopCallback);
  }

  void verif(){
    int score = 0;
    var w = controller.text.split(" ");
    if(w.length > 1 && w[0] == word1[choose[0]]) ++score;
    if(w.length > 2 && w[1] == word2[choose[1]]) ++score;
    if(w.length > 3 && w[2] == word3[choose[2]]) ++score;
    if(w.length > 4 && w[3] == word4[choose[3]]) ++score;
    print("Score : " + score.toString());


    DatabaseService().createSentenceTest(score);

    if(score == 4){
      _timer.cancel();
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Success(score: score)
          )
      );
    }else{
      _timer.cancel();
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Failure(score: score)
          )
      );
    }
  }
}