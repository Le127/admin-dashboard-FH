import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:flutter/widgets.dart';

import '../models/category.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Categoria> categorias = [];

  getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);

    categorias = [...categorias, ...categoriesResp.categorias];
    print(categorias);
    notifyListeners();
  }
}
