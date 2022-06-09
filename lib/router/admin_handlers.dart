import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:provider/provider.dart';
import '../ui/views/register_view.dart';

class AdminHandlers {
  // Login
  static Handler login = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    //Si no esta autenticado devuelve el LoginView
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const DashboardView();
    }
  });

//Register
  static Handler register = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    //Si no esta autenticado devuelve el ResisterView
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterView();
    } else {
      return const DashboardView();
    }
  });
}
