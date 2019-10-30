import 'package:flutter/material.dart';
import 'package:front/Mouvement/CountMouvement.dart';
import 'package:front/Sentence/sentence.dart';
import 'package:front/main.dart';
import 'package:front/settings.dart';

import 'dart:math';

class StateQuizz {
  static final StateQuizz _instance = StateQuizz._internal();

  var tests = ["mvt", "sentence"];
  var comingFromMain = false;
  StatefulWidget widgetFromMain;


  factory StateQuizz(){
    return _instance;
  }

  StateQuizz._internal();

  StatefulWidget getNextTest(comingFrom){
    if(tests.isEmpty){
      print("fin du quizz");
      return Settings();
    }else{

      if(!comingFromMain) {
        comingFromMain = true;
        print(tests);
        widgetFromMain = launchWidget(chooseTest());
        return widgetFromMain;
      }
      else if(comingFrom == ""){
        return launchWidget(chooseTest());
      }
      else{
        return widgetFromMain;
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
    else if (tests[value] == "sentence") {
      tests.removeAt(value);
      return Sentence();
    }
  }


  int chooseTest(){
    final _random = new Random();
    var _stateNB = 0 + _random.nextInt(tests.length - 0);
    return _stateNB;
  }
}