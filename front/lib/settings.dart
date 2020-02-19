import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:scheduled_notifications/scheduled_notifications.dart';

import 'BDD/DatabaseService.dart';
import 'Sentence/sentence.dart';

import 'package:front/stateQuizz.dart';
import 'settingsModel.dart';
import 'package:front/colors.dart';



class Settings extends StatefulWidget {
  @override
  SettingsFormState createState(){
    return SettingsFormState();
  }

}

class SettingsFormState extends State<Settings>{

  final _formKey = GlobalKey<FormState>();
  static var _settingsModel = new SettingsModel();
  String _time ="00:00";
  String _time2 ="00:00";
  String _selectedText = "Heures";

  void _changeTime(newTime){
    setState((){
      _time = newTime;
    });
  }

  void _changeTime2(newTime){
    setState((){
      _time2 = newTime;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètre"),
        backgroundColor: PrimaryColor,
      ),
      body: Container(
        decoration: new BoxDecoration(color: PrimaryColor),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: ListView(
              children: form()
            ),
          ),
        ),


      ),
    );
  }



  form(){
    return <Widget>[
      Padding(
        padding: EdgeInsets.all(15.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Prénom',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          validator: (value) {
            if(value.isEmpty){
              return 'Entre ton prénom!';
            }
            return null;
          },
          onSaved: (value) => setState(() => _settingsModel.name =
              value),
        ),
      ),
      FlatButton(
          onPressed: () {
            DatePicker.showTimePicker(context, showTitleActions: true,
                onConfirm: (date) {
                  var formatter = new DateFormat("Hm");
                  _changeTime(formatter.format(date));
                  _settingsModel.beginningParty = date;
                }, currentTime: DateTime.now());

          },
          child: Text(
            'Choisi l\'heure de début de soirée!',
            style: TextStyle(color: Colors.white),
          )
      ),
      Text(
        '$_time',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      FlatButton(
          onPressed: () {
            DatePicker.showTimePicker(context, showTitleActions: true,
                onConfirm: (date) {
                  var formatter = new DateFormat("Hm");
                  _changeTime2(formatter.format(date));
                  _settingsModel.endingParty = date;
                }, currentTime: DateTime.now());

          },
          child: Text(
            'Choisi l\'heure de fin de soirée!',
            style: TextStyle(color: Colors.white),
          )
      ),
      Text(
        '$_time2',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          'Rappel toutes les : ',
          style: TextStyle(color: Colors.white),
        ),
      ),
     Padding(
       padding: EdgeInsets.all(15.0),
       child:  new Theme(
         data: Theme.of(context).copyWith(
             canvasColor: PrimaryColor
         ),
         child: DropdownButton<String>(
           hint: Text("Status"),
           value: _selectedText,
           items: <String>['Heures', '30 minutes', '10 minutes', 'test (10 sec)'].map((String value) {
             return new DropdownMenuItem<String>(
               value: value,
               child: new Text('$value',style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: Colors.white
               ),),
             );
           }).toList(),
           onChanged: (String val) {
             _selectedText = val;
             setState(() {
               _selectedText = val;
             });
           },
         ),
       ),
     ),
      Padding(
        padding: EdgeInsets.all(15.0),
        child:  TextFormField(
          decoration: InputDecoration(
              labelText: 'Téléphone d\'un ami',
              labelStyle: TextStyle(
                  color: Colors.white
              ),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              )
          ),
          validator: (value) {
            RegExp exp = new RegExp("^(?:(?:\\+|00)33|0)\\s*[1-9](?:[\\s"
                ".-]*\\d{2}){4}\$");
            if (!exp.hasMatch(value)) {
              return 'Ce numéros n\'est pas valide!';
            }
            else if(value.isEmpty){
              return 'Entre un numéro!';
            }
            return null;
          },
          onSaved: (value) => setState(() => _settingsModel.friendsNumber =
              value),
        ),
      ),
     Padding(
       padding: EdgeInsets.all(15.0),
       child:TextFormField(
         decoration: InputDecoration(
             labelText: 'Adresse où tu vas dormir ce soir!',
             labelStyle: TextStyle(
                 color: Colors.white
             ),
             fillColor: Colors.white,
             focusedBorder: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.white, width: 2.0),
               borderRadius: BorderRadius.circular(25.0),
             )
         ),
         validator: (value) {
           if (value.isEmpty) {
             return 'Entre une adresse!';
           }
           return null;
         },
         onSaved: (value) => setState(() => _settingsModel.address =
             value),
       ),
     ),
      
      RaisedButton(
        color: PrimaryAssentColor,
        textColor: Colors.white,
        onPressed: () {
          final form = _formKey.currentState;
          if (form.validate()) {
            form.save();

            print("Settings : " + _settingsModel.name + "\nNum " +
                _settingsModel.friendsNumber + "\nAdresse " +
                _settingsModel.address + "\nHoraire de " +
                _settingsModel.beginningParty.toString() + " a " + _settingsModel.endingParty.toString());
            DatabaseService dbb = new DatabaseService();
            dbb.saveId(_settingsModel.name);
            scheduleNotif();
            /* Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Sentence()
                          )
                      );*/
          }
        },
        child: Text('Enregistrer'),
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
                  builder: (context) => StateQuizz().getNextTest("settings")
              )
          );
        },
        child: Text(
          "Tests non alcoolisé!",
        ),
      ),
    ];
  }

  void scheduleNotif() async {
    final date1 = _settingsModel.beginningParty;
    final date2 = _settingsModel.endingParty;

    if(date1 != null && date2 != null) {
      final difference = date2
          .difference(date1)
          .inHours;

      print(difference);

      int firstNotification = await ScheduledNotifications.scheduleNotification(
          new DateTime.now()
              .add(new Duration(seconds: 0))
              .millisecondsSinceEpoch,
          "",
          "Notification",
          "A partir du début de la soirée une notification toutes les heures");

      switch (_selectedText) {
        case 'Heures':
          for (int i = 0; i < difference; ++i) {
            int notificationId = await ScheduledNotifications
                .scheduleNotification(
                _settingsModel.beginningParty
                    .add(new Duration(hours: i))
                    .millisecondsSinceEpoch,
                "Attention",
                "Tu es en soirée",
                "Fais le test avant d'utiliser ton tel");
          }
          print("Heures");
          break;
        case '30 minutes':
          for (int i = 0; i < difference * 2; ++i) {
            int notificationId = await ScheduledNotifications
                .scheduleNotification(
                _settingsModel.beginningParty
                    .add(new Duration(minutes: 30 * i))
                    .millisecondsSinceEpoch,
                "Attention",
                "Tu es en soirée",
                "Fais le test avant d'utiliser ton tel");
          }
          print("30 minutes");
          break;
        case '10 minutes':
          for (int i = 0; i < difference * 6; ++i) {
            int notificationId = await ScheduledNotifications
                .scheduleNotification(
                _settingsModel.beginningParty
                    .add(new Duration(minutes: 10 * i))
                    .millisecondsSinceEpoch,
                "Attention",
                "Tu es en soirée",
                "Fais le test avant d'utiliser ton tel");
          }
          print("10 minutes");
          break;
        default:
          int notificationId = await ScheduledNotifications
              .scheduleNotification(
              _settingsModel.beginningParty
                  .add(new Duration(seconds: 10))
                  .millisecondsSinceEpoch,
              "Attention",
              "Tu es en soirée",
              "Fais le test avant d'utiliser ton tel");
          print("default");
      }
    }
  }
}