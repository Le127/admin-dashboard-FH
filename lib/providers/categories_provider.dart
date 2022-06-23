// ignore_for_file: avoid_print

import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:flutter/widgets.dart';

import '../models/category.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Categoria> categorias = [];

  Future getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);

    categorias = [...categorias, ...categoriesResp.categorias];
    print(categorias);
    notifyListeners();
  }

  //Add Category
  Future newCategory(String name) async {
    final data = {'nombre': name};

    try {
      final json = await CafeApi.httpPost('/categorias', data);
      final newCategory = Categoria.fromMap(json);

      categorias.add(newCategory);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

//Update Category
  Future updateCategory(String id, String name) async {
    final data = {'nombre': name};

    try {
      await CafeApi.httpPut('/categorias/$id', data);

      //Recorre la lista, si category.id es disinto al id recibido no hace ningun cambio. Caso contrario cambia el nombre de la categoria.
      categorias = categorias.map(
        (category) {
          if (category.id != id) return category;

          category.nombre = name;
          return category;
        },
      ).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

//Delete Category
  Future deleteCategory(String id) async {
    try {
      await CafeApi.httpDelete('/categorias/$id', {});

      //Elimina la categoria solo si categoria.id es igual al id que esta recibiendo
      categorias.removeWhere((categoria) => categoria.id == id);

      notifyListeners();
    } catch (e) {
      print(e);
      print('Error al eliminar categoría');
    }
  }
}
