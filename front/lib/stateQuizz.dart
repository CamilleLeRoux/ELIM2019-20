import 'package:flutter/material.dart';
import 'package:front/Mouvement/CountMouvement.dart';
import 'package:front/Sentence/sentence.dart';
import 'package:front/main.dart';
import 'package:front/settings.dart';
import 'package:front/ligneDroite.dart';
import 'package:front/endOk.dart';
import 'dart:math';

class StateQuizz {
  static final StateQuizz _instance = StateQuizz._internal();

  var tests = ["mvt", "ligneDroite"];
  var comingFromMain = false;


  factory StateQuizz(){
    return _instance;
  }

  StateQuizz._internal();

  StatefulWidget getNextTest(comingFrom){
    if(tests.isEmpty){
      print("fin du quizz");
      return EndOk();
    }else{

      if(!comingFromMain) {
        comingFromMain = true;
        return new Sentence();
      }
      else if(comingFrom == ""){
        return launchWidget(chooseTest());
      }
      else{
        return new Sentence();
      }
    }
  }
  StatefulWidget launchWidget(value){
    print("va chercher une autre page " + value.toString() + "  "
        + tests[value]);
    if (tests[value] == "mvt") {
      tests.removeAt(value);
      return CountMouvement(0);
    }
    else if (tests[value] == "ligneDroite") {
      tests.removeAt(value);
      return LigneDroite(0);
    }
  }


  int chooseTest(){
    final _random = new Random();
    var _stateNB = 0 + _random.nextInt(tests.length - 0);
    return _stateNB;
  }
}