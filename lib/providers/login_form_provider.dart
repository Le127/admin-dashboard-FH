// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier {
  //referencia al AuthProvider

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

//Valida las entradas del formulario con la informacion del Form que ya tiene asociada en el formKey
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
