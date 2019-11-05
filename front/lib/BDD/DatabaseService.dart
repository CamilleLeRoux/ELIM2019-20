import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/BDD/DatabaseID.dart';


class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal();
  final Firestore _db = Firestore.instance;


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

}