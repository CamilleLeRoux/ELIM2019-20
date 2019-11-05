import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/BDD/DatabaseID.dart';
import 'package:front/Model/scoreModel.dart';

class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal();
  final Firestore _db = Firestore.instance;
  List<ScoreModel> scores = new List();

  factory DatabaseService(){
    return _instance;
  }

  DatabaseService._internal();

  addScore(int score, bool drunk){
    _db.collection("profil").document(idUser).collection("testScore").add
      ({"score":score, "drunk": drunk, "timeStamp": DateTime.now().toString()});
  }

  getScores(){
    ScoreModel score;
    _db.collection("profil").document("1").collection("testScore").getDocuments()
        .then((QuerySnapshot snapshot){
          snapshot.documents.forEach((f)=>{
            score = new ScoreModel(f.data["score"],
              f.data["timeStamp"], f.data["drunk"]),
            scores.add(score)
          });
    });
  }


}
