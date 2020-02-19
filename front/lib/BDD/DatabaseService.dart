import 'dart:convert';
import 'package:front/Model/scoreModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService{
  saveId(name) async{
    final prefs = await SharedPreferences.getInstance();
    final key = "name";
    final value = name;
    prefs.setString(key, value);
    print('savec $value');
  }


  addScore(int score, bool drunk) async{
    print("save");
    final prefs = await SharedPreferences.getInstance();
    List<String> scores = prefs.getStringList("scores");
    if(scores == null){
      scores = [];
    }
    ScoreModel scoreM = new ScoreModel(score, drunk);
    scoreM.toJson();
    scores.add(json.encode(scoreM));
    print(scores);
    prefs.setStringList("scores", scores);
  }

  getScores() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("scores");
  }
}
