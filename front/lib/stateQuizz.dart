import 'package:flutter/material.dart';
import 'package:front/Mouvement/CountMouvement.dart';
import 'package:front/Sentence/sentence.dart';
import 'package:front/ligneDroite.dart';
import 'package:front/BDD/DatabaseService.dart';
import 'package:front/settings.dart';
import 'package:front/kMeans.dart';

import 'dart:math';

class StateQuizz {
  static final StateQuizz _instance = StateQuizz._internal();

  var tests = ["mvt", "ligneDroite"];
  var comingFromMain = false;
  bool drunk = true;
  int score = 0;
  kMeans kmeans = new kMeans();

  factory StateQuizz(){
    return _instance;
  }

  StateQuizz._internal();

  StatefulWidget getNextTest(comingFrom){
    if(tests.isEmpty){
      DatabaseService().addScore(score, drunk);
      if(drunk){
        return kmeans.kMeansScore(score);
      }else{
        return Settings();
      }
    }else{
      if(!comingFromMain) {
        DatabaseService().getScores();
        comingFromMain = true;
        if(comingFrom == "settings"){
           drunk = false;
        }
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