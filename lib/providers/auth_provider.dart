import 'package:flutter/widgets.dart';

//Este provider tiene la informacion de que usuario esta conectado, el token de acceso, etc

class AuthProvider extends ChangeNotifier {
  String? _token;

  login(String email, String password) {
    //Peticion http

    _token = 'adsdasdsdsjnb32s.dfsdffdhgdfasa.22fsdv';
    print('almacenarJWT : $_token');

    //Navegar al dashboard que aun no esta creado

    notifyListeners(); //para que se redibuje en los lugares necesarios
  }
}
