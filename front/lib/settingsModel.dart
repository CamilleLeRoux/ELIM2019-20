class SettingsModel{

  String name = '';
  String address = 'Résidence les dolines';
  DateTime beginningParty;
  DateTime endingParty;
  String friendsNumber = '0623565261';

  String getNumber(){
    return friendsNumber;
  }

}