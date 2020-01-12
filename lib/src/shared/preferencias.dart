import 'package:shared_preferences/shared_preferences.dart';

class Preference {

  static final  Preference  _instancia = new Preference._internal();

  factory Preference(){
    return _instancia;
  }


  Preference._internal();


  SharedPreferences prefs;

  initPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  get like  {
    return prefs.getBool('like') ?? false;
  }

  // set liked(key,){
  //   prefs.setString();
  // }

}