import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import '../ui/views/register_view.dart';

class AdminHandlers {
  // Login
  static Handler login = Handler(handlerFunc: (context, parameters) {
    return const LoginView();
  });

//Register
  static Handler register = Handler(handlerFunc: (context, parameters) {
    return const RegisterView();
  });
}
