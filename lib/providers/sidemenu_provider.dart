import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
  static late AnimationController menuController;
  static bool isOpen = false;

  String _currentPage = '';

  String get currentPage {
    return _currentPage;
  }

  void setCurrentPageUrl(String routeName) {
    _currentPage = routeName;
    //El retraso es para que la aplicacion tenga tiempo de crear la view y luego notificar para redibujar.
    Future.delayed(const Duration(milliseconds: 100), () => notifyListeners());
  }

//Animacion de aparicion y salida del SideBar
  static Animation<double> movement = Tween<double>(begin: -200, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

//Opacidad del resto del dashboard cuando esta o no el SideBar
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  //Métodos del menuController

  //Open
  static void openMenu() {
    isOpen = true;
    menuController.forward(); //Inicia la animación
  }

  //Close
  static void closeMenu() {
    isOpen = false; //ESTABA EN TRUE
    menuController.reverse(); //Caso opuesto a Open
  }

  //Toogle
  static void toogleMenu() {
    (isOpen) ? menuController.reverse() : menuController.forward();
    isOpen = !isOpen;
  }
}
