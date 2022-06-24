import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/cafe_api.dart';

import 'services/local_storage.dart';
import 'services/notifications_service.dart';
import 'services/navigation_service.dart';

import 'providers/auth_provider.dart';
import 'providers/categories_provider.dart';
import 'providers/sidemenu_provider.dart';
import 'providers/users_provider.dart';

import 'ui/layouts/auth/auth_layout.dart';
import 'ui/layouts/dashboard/dashboard_layout.dart';
import 'ui/layouts/splash/splash_layout.dart';

import 'router/router.dart';

Future<void> main() async {
  //Configuracion LocalStorage
  await LocalStorage.configurePrefs();
  //Configuracion Dio
  CafeApi.configureDio();
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
        ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SideMenuProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider())
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
      scaffoldMessengerKey: NotificationsService.messengerKey,
      navigatorKey: NavigationService.navigatorKey,
      //Genera las rutas con las configuraciones cargadas en el main
      onGenerateRoute: (routeSettings) =>
          Flurorouter.router.generator(routeSettings),
      // El child es la View que se va a mostrar, basada en el url que tenga
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
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
