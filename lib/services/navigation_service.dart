import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//Navega y guarda en el historial
  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
//Navega y NO guarda en el historial
  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
