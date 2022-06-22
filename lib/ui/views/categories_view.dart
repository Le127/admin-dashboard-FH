import 'package:flutter/material.dart';
import 'package:admin_dashboard/datatables/categories_datasource.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';



//La View default de panel administrativo para crear otras View
class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Categorias', style: CustomLabels.h1),
        const SizedBox(height: 10),
        PaginatedDataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Categoría')),
            DataColumn(label: Text('Creado por')),
            DataColumn(label: Text('Acciones')),
          ],
          source: CategoriesDTS(),
        )
      ],
    );
  }
}
