import 'package:admin_dashboard/models/usuario.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Usuario? user;


  // TODO: Como voy  a actualizar el usuario dle provider


  bool validForm(){
    return formKey.currentState!.validate();
  }
}
