import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';

void main() {
  //Configuracion de rutas
  Flurorouter.configureRoutes();
  //Ejecuta la App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      //Genera las rutas con las configuraciones cargadas en el main
      onGenerateRoute: (routeSettings) =>
          Flurorouter.router.generator(routeSettings),
      //El child es la Vista que necesitamos mostrar, dependiendo de la url en la que se encuentre
      builder: (_, child) {
        return AuthLayout(child: child!);
      },
    );
  }
}
