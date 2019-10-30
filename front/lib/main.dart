import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/testBdd.dart';
import 'Sentence/sentence.dart';
import 'settings.dart';
import 'package:front/Mouvement/CountMouvement.dart';
import 'package:front/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          children: <Widget>[

            FlatButton(
              color: PrimaryAssentColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueGrey[100],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => TestBdd()
                    )
                );
              },
              child: Text(
                "Commencer le test!",
              ),
            ),
            FlatButton(
              color: PrimaryAssentColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Sentence()
                    )
                );
              },
              child: Text(
                "Phrase",
              ),
            ),
            FlatButton(
              color: PrimaryAssentColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CountMouvement(0)
                    )
                );
              },
              child: Text(
                "Mouvement",
              ),
            ),
          ],
        ),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
