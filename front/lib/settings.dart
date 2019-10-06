import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
                        labelText: 'Entre ton prénom'
                    )
                ),
                FlatButton(
                    onPressed: () {
                      DatePicker.showTimePicker(context, showTitleActions: true,
                          onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());
                    },
                    child: Text(
                      'Choisi l\'heure de début de soirée!',
                      style: TextStyle(color: Colors.blue),
                    )
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Entre le numéros de téléphone d\'un ami'
                  ),
                  validator: (value) {
                    RegExp exp = new RegExp("^(?:(?:\\+|00)33|0)\\s*[1-9](?:[\\s"
                        ".-]*\\d{2}){4}\$");
                    if (exp.hasMatch(value)) {
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
                      labelText: 'Entre l\'adresse où tu vas dormir ce soir!'
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
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
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