import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import '../ui/views/user_view.dart';
import 'router.dart';

import '../providers/auth_provider.dart';
import '../providers/sidemenu_provider.dart';

import 'package:admin_dashboard/ui/views/categories_view.dart';

import '../ui/views/blank_view.dart';
import '../ui/views/dashboard_view.dart';
import '../ui/views/icons_view.dart';
import '../ui/views/users_view.dart';
import '../ui/views/login_view.dart';

class DashboardHandlers {
  // Dashboard Main
  static Handler dashboard = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    //Setea CurrentPage
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    //Si esta autenticado devuelve  DashboardView

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  //Icons
  static Handler icons = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    //Setea CurrentPage
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.iconsRoute);

    //Si esta autenticado devuelve IconsView
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

//Categories
  static Handler categories = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    //Setea CurrentPage
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.categoriesRoute);

    //Si esta autenticado devuelve CategoriesView
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CategoriesView();
    } else {
      return const LoginView();
    }
  });

//Users Handler
  static Handler users = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    //Setea CurrentPage
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);

    //Si esta autenticado devuelve UsersView
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });

//User Handler
  static Handler user = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    //Setea CurrentPage
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);
    //Si esta autenticado  y tiene UID devuelve UserView
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) {
        return UserView(uid: params['uid']!.first);
      } else {
        return const UsersView();
      }
    } else {
      return const LoginView();
    }
  });

//Blank Handler
  static Handler blank = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    //Setea CurrentPage
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);

    //Si esta autenticado devuelve BlankView
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });
}
