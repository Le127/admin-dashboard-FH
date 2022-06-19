import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/widgets.dart';

//Este provider tiene la informacion de que usuario esta conectado, el token de acceso, etc

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }
//LOGIN
  login(String email, String password) {
    //Peticion http

    _token = 'adsdasdsdsjnb32s.dfsdffdhgdfasa.22fsdv';
    LocalStorage.prefs.setString('token', _token!);
    // ignore: avoid_print
    print('almacenarJWT : $_token');

    authStatus = AuthStatus.authenticated;

    notifyListeners(); //para que se redibuje en los lugares necesarios

    //Cambia el url
    NavigationService.repalceTo(Flurorouter.dashboardRoute);
  }

//REGISTER
  register(String email, String password, String name) {
    final data = {
      "nombre": name,
      "correo": email,
      "password": password,
    };

    //POST
    CafeApi.httpPost('/usuarios', data).then(
      (json) {
        print(json);

        final authResponse = AuthResponse.fromMap(json);
        user = authResponse.usuario;
        authStatus = AuthStatus.authenticated;

        LocalStorage.prefs.setString('token',authResponse.token);
        //Cambia el url y navega al dashboard
        NavigationService.repalceTo(Flurorouter.dashboardRoute);
        // ignore: avoid_print
        print('almacenarJWT : $_token');
        notifyListeners(); //para que se redibuje en los lugares necesarios
      },
    ).catchError((e) {
      print('error en : $e');
      //Todo: Mostrar notificación de error
    });
  }

  // Devuelve true si existe un token
  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //todo: Ir al backend y comprobar si el JWT es valido
    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}
