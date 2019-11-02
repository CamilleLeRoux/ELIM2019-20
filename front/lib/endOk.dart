import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:front/colors.dart';
import 'package:front/settingsModel.dart';


class EndOk extends StatefulWidget{
  @override
  EndOkState createState(){
    return EndOkState();
  }
}

class EndOkState extends State<EndOk>{

  SettingsModel model  = SettingsModel();

   @override
  void initState() {
     super.initState();
   }
  Future<bool> _willPopCallback() async {
    return false;
  }


  Widget build(BuildContext context){
    return new WillPopScope(
        child: Scaffold(
          backgroundColor: PrimaryColor,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child:Column(
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "AMI",
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Image.asset(
                                "assets/phone.png",
                                width: 72,
                              )
                            ],
                          ),
                          color: PrimaryAssentColor,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,

                          onPressed: () {
                            callFriend();
                          },
                        ),
                        height: 100,
                        margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                      ),
                      Container(
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "MAISON",
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Image.asset(
                                "assets/walk.png",
                                width: 72,
                              )
                            ],
                          ),

                          color: PrimaryAssentColor,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,

                          onPressed: () {
                            openMaps();
                          },
                        ),
                        height: 100,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      ),

                    ],

                  )
                ),
                Container(
                  child:Column(
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "HOTEL",
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Image.asset(
                                "assets/bed.png",
                                width: 72,
                              )
                            ],
                          ),
                          color: PrimaryAssentColor,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          onPressed: () {
                            openHotel();
                          },
                        ),
                        height: 100,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      ),
                      Container(
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "TAXI",
                                style: TextStyle(fontSize: 40.0),
                              ),
                              Image.asset(
                                "assets/taxi.png",
                                width: 72,
                              )
                            ],
                          ),
                          color: PrimaryAssentColor,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          onPressed: () {
                            openTaxi();
                          },
                        ),
                        height: 100,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      ),
                    ],
                  )
                ),
              ],


            )


          ),
        ),
        onWillPop: _willPopCallback);
  }

  void callFriend() async{
    var uri = "tel:" + model.getNumber();
    if (await canLaunch(uri)) {
        await launch(uri);
    }
  }

  void openMaps() async{
    var url = 'https://www.google.com/maps/search/?api=1&query='+ Uri
        .encodeFull(model.address);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openTaxi() async{
    var url = 'https://www.google.com/maps/search/?api=1&query=hotel';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openHotel() async{
    var url = 'https://www.google.com/search/?api=1&query=cab';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

