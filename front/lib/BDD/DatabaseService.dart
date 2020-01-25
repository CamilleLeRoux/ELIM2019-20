import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/BDD/DatabaseID.dart';
import 'package:front/Model/scoreModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal();
  final Firestore _db = Firestore.instance;
  List<ScoreModel> scores = new List();

  factory DatabaseService(){
    return _instance;
  }

  DatabaseService._internal();

  addNewUser (){
    _db.collection("profil").getDocuments().then((QuerySnapshot snapshot){
      var newId = snapshot.documents.length + 1;
      _db.collection("profil").add({"id": newId});
      idUser = newId.toString();
      saveId();
    });
  }

  saveId() async{
    final prefs = await SharedPreferences.getInstance();
    final key = "idUser";
    final value = idUser;
    prefs.setString(key, value);
    print('savec $value');
  }


  addScore(int score, bool drunk){
    _db.collection("profil").document(idUser).collection("testScore").add
      ({"score":score, "drunk": drunk, "timeStamp": DateTime.now().toString()});
  }

  getScores(){
    ScoreModel score;
    _db.collection("profil").document(idUser).collection("testScore")
        .getDocuments()
        .then((QuerySnapshot snapshot){
          snapshot.documents.forEach((f)=>{
            score = new ScoreModel(f.data["score"],
              f.data["timeStamp"], f.data["drunk"]),
            scores.add(score)
          });
    });
  }


}
