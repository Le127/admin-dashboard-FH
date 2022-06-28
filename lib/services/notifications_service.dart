import 'package:flutter/material.dart';

class NotificationsService {
//GlobalKey para las notificaciones (configuracion en Main «scaffoldMessengerKey»)
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

//SnackBar Error
  static showSnackbarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
    //Muestra snackbar
    messengerKey.currentState!.showSnackBar(snackBar);
  }

//SnackBar Correcto
  static showSnackbarOk(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.9),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
    //Muestra snackbar
    messengerKey.currentState!.showSnackBar(snackBar);
  }

//Modal
  static showBusyIndicator(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
// ignore: sized_box_for_whitespace
      content: Container(
        width: 100,
        height: 100,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(context: context, builder: (_) => dialog);
  }
}
