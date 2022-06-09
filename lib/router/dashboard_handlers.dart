import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import '../providers/auth_provider.dart';
import '../ui/views/dashboard_view.dart';

class DashboardHandlers {
  // Dashboard Main
  static Handler dashboard = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    //Si esta autenticado devuelve el Dashboard
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });
}
