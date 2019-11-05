import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/BDD/DatabaseID.dart';
import 'package:front/Model/sentenceModel.dart';

class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal();
  final Firestore _db = Firestore.instance;
  List<SentenceModel> lSM = new List();



  factory DatabaseService(){
    return _instance;
  }
  DatabaseService._internal();

  createMovementTest(bool _success, bool drunk){
    return _db.collection('movementTest').document().setData({"idUser":
    idUser,"success": _success, "timeStamp": DateTime.now().toString(), "drunk": drunk});
  }

  createSentenceTest(int score, bool drunk){
    _db.collection('sentenceTest').add({"score": score, "idUser":
    idUser, "timeStamp": DateTime.now().toString(), "drunk": drunk});
  }

  List<SentenceModel> getSentenceData(){
    _db.collection("sentenceTest").getDocuments()
      .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => {
          addToList(f)
        });
      });
    return lSM;
  }

  addToList(f){
    SentenceModel sM;
    if(f.data["idUser"] == idUser){
      sM = new SentenceModel(f.data["idUser"], f
          .data["score"],
          f.data["timeStamp"], f.data["drunk"]);
      lSM.add(sM);
    }
  }

}
