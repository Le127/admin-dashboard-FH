import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/usuario.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  Usuario? user;

  //Esta es una forma sencilla de actualizar el user, llamando a un notifyListener personalizado en el lugar que querramos.
  void updateListener() {
    notifyListeners();
  }

//Copia con los valores de usuario para actualizar usuario
  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) {
    user = Usuario(
        rol: rol ?? user!.rol,
        estado: estado ?? user!.estado,
        google: google ?? user!.google,
        nombre: nombre ?? user!.nombre,
        correo: correo ?? user!.correo,
        uid: uid ?? user!.uid);

    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

//ACTUALIZAR USUARIO
  Future updateUser() async {
    if (!_validForm()) return false;

    final data = {
      'nombre': user!.nombre,
      'correo': user!.correo,
    };

    try {
      final resp = await CafeApi.httpPut('/usuarios/${user!.uid}', data);
      // ignore: avoid_print
      print(resp);

      return true;
    } catch (e) {
      // ignore: avoid_print
      print('error en updateUser: $e');
      return false;
    }
  }
}
