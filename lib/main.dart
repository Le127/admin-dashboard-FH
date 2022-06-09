import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';

Future<void> main() async {
  //Configuracion LocalStorage
  await LocalStorage.configurePrefs();
  //Configuracion de rutas
  Flurorouter.configureRoutes();

  //Ejecuta la App
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      navigatorKey: NavigationService.navigatorKey,
      //Genera las rutas con las configuraciones cargadas en el main
      onGenerateRoute: (routeSettings) =>
          Flurorouter.router.generator(routeSettings),
      //El child es la Vista que necesitamos mostrar, dependiendo de la url en la que se encuentre
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const Center(
            child: Text('Checking'),
          );
        }
        //Si esta autenticado se dirige al Dashboard, caso contrario al Login
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashBoardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
    );
  }
}
