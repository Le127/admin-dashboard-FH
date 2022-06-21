// ignore_for_file: avoid_print

import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
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
    final data = {
      "correo": email,
      "password": password,
    };

    CafeApi.httpPost('/auth/login', data).then((json) {
      print(json);

      //Decodifica el Json
      final authResponse = AuthResponse.fromMap(json);
      //Guarda el usuario
      user = authResponse.usuario;
      //Autentica usuario
      authStatus = AuthStatus.authenticated;
      //Almacena token localmente
      LocalStorage.prefs.setString('token', authResponse.token);
      //Navega  url
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      //Configura nuevamente Dio para que tome el ultimo token
      CafeApi.configureDio();
      notifyListeners(); //redibuje en los lugares necesarios
    }).catchError((e) {
      //Todo: Mostrar notificación de error
      print('error en : $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos ');
    });
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

        LocalStorage.prefs.setString('token', authResponse.token);
        //Cambia el url y navega al dashboard
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        //Configura nuevamente Dio para que tome el ultimo token
        CafeApi.configureDio();
        notifyListeners(); //redibuje en los lugares necesarios
      },
    ).catchError((e) {
      print('error en : $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos ');
    });
  }

  // Devuelve true si existe un token
  Future<bool> isAuthenticated() async {
    //Obtiene el token que esta almacenado localmente
    final token = LocalStorage.prefs.getString('token');

    //Si no hay token, no se autentica.
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //Comprueba si el JWT es valido. En CafeApi se envia el token por header
    try {
      final resp = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token',authResponse.token); //setea con el nuevo token para impedir que se cierre la sesion del usuario
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

//Logout
  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
