import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/ligneDroite.dart';
import 'package:front/testBdd.dart';
import 'package:front/testBille.dart';
import 'BDD/DatabaseID.dart';
import 'BDD/DatabaseService.dart';
import 'Sentence/sentence.dart';
import 'settings.dart';
import 'package:front/Mouvement/CountMouvement.dart';
import 'package:front/colors.dart';
import 'package:front/stateQuizz.dart';

import 'package:shared_preferences/shared_preferences.dart';



void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: MyHomePage(title: 'ELIM 2019-20'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  initState(){
    super.initState();
    checkIfID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
        title: Row(
            children: [
              Image.asset(
                'assets/icon.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text(widget.title))
            ],
        ),
          actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => Settings()
                  )
              );
            },
          ),
        ],
        backgroundColor: PrimaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
            child:FlatButton(
                color: PrimaryAssentColor,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueGrey[100],
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StateQuizz().getNextTest("main")
                      )
                  );
                },
                child: Text(
                  "Commencer le test!",
                  style: TextStyle(fontSize: 40.0),
                  textAlign: TextAlign.center,
                ),
              ),
              height: 140,
              margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            ),
          ],
        ),
      ),
    );
  }

  checkIfID() async{
    String _id = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString("idUser");
    if(_id != "" && _id != null){
      print("logged");
    }else{
      DatabaseService dbb = new DatabaseService();
      dbb.addNewUser();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
          => new Settings()));
    }
  }


}
