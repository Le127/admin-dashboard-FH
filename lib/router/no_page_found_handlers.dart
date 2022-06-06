import 'package:fluro/fluro.dart';

import '../ui/views/no_page_found_view.dart';

class NoPageFoundHandlers {
  // Login
  static Handler noPageFoundView = Handler(handlerFunc: (context, parameters) {
    return const NoPageFoundView();
  });
}
