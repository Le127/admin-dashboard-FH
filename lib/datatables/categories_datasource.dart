import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoriesDTS extends DataTableSource {
  final List<Categoria> categorias;
  final BuildContext context;

  CategoriesDTS(this.categorias, this.context);

  @override
  DataRow getRow(int index) {
    final categoria = categorias[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(categoria.id)),
        DataCell(Text(categoria.nombre)),
        DataCell(Text(categoria.usuario.nombre)),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  print('Editando: $categoria');
                },
                icon: const Icon(Icons.edit_outlined)),
            IconButton(
                onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('¿Está seguro de borrar?'),
                    content:
                        Text('¿Borrar devinitivamente ${categoria.nombre}?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Si, borrar'))
                    ],
                  );

                  showDialog(context: context, builder: (_) => dialog);
                },
                icon: Icon(
                  Icons.delete_outlined,
                  color: Colors.red.withOpacity(0.8),
                )),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
}
