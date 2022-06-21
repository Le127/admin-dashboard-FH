// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  //Valida las entradas del formulario con la informacion del Form que ya tiene asociada en el formKey.
  // Devuelve true si es valido, caso contrario false
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valid... Login');
      print(email);
      print(password);
      print(name);
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}
