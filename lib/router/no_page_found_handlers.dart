import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import '../ui/views/no_page_found_view.dart';

class NoPageFoundHandlers {
  // Login
  static Handler noPageFoundView = Handler(handlerFunc: (context, parameters) {
    //Setea currentPage para que se puedan seleccionar los items del sideBar en un 404.
    //De lo contrario queda el item seleccionado sin la posibilidad de volver a seleccionarlo para salir del 404.
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('/404');
    return const NoPageFoundView();
  });
}
