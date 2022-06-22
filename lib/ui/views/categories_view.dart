import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/datatables/categories_datasource.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

//La View default de panel administrativo para crear otras View
class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

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
          header: const Text('Categorías disponibles', maxLines: 2),
          onRowsPerPageChanged: (value) {
            _rowsPerPage = value ?? 10;
            setState(() {});
          },
          rowsPerPage: _rowsPerPage,
          actions: [
            CustomIconButton(
                onPressed: () {}, text: 'Crear', icon: Icons.add_outlined)
          ],
        )
      ],
    );
  }
}
