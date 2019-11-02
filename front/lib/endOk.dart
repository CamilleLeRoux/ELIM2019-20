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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("Bravo!! Ton taux d'alcoolémie semble correct!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40.0, color: Colors.white),),
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),

                ),
                Image.asset(
                  "assets/icon.png",
                  width: 170,
                )
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

