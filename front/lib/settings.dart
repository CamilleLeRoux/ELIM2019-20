import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'settingsModel.dart';

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

  void _changeTime(newTime){
    setState((){
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètre"),
      ),
      body: Container(
        padding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Prénom'
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
                      style: TextStyle(color: Colors.blue),
                    )
                ),
                Text(
                  '$_time',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Téléphone d\'un ami'
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
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Adresse où tu vas dormir ce soir!'
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
                RaisedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      Scaffold
                          .of(context)
                          .showSnackBar(SnackBar(content: Text
                        ('Enregistrement')));
                      print("Settings : " + _settingsModel.name + "\nNum " +
                          _settingsModel.friendsNumber + "\nAdresse " +
                          _settingsModel.address + "\n Horaire " +
                          _settingsModel.beginningParty.toString());
                      }
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            ),
          ),
        ),


      ),
    );
  }
}