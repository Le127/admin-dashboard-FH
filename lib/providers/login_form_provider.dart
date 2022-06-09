// ignore_for_file: avoid_print

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier {
  //referencia al AuthProvider
  final AuthProvider authProvider;

  LoginFormProvider(this.authProvider);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

//Valida las entradas del formulario con la informacion del Form que ya tiene asociada en el formKey
  validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valid... Login');
      print(email);
      print(password);

      authProvider.login(email, password);
      
    } else {
      print('Form not valid');
    }
  }
}
