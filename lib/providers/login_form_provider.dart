import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

//Valida las entradas del formulario con la informacion del Form que ya tiene asociada en el formKey
  validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valid... Login');
    } else {
      print('Form not valid'); 
    }
  }
}
