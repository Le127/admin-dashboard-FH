import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

import '../../models/usuario.dart';

class UserView extends StatefulWidget {
  final String uid;

  const UserView({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;

  @override
  void initState() {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid).then((userDB) {
      setState(() {
        user = userDB;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('User View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (user == null)
            Container(
              alignment: Alignment.center,
              height: 500,
              child: const CircularProgressIndicator(),
            ),
          if (user != null) _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      //Ancho de la columna
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          //TODO: Avatar
          Container(
            color: Colors.red,
            height: 200,
            width: 250,
          ),

          // TODO: Formulario Actualizacion

          Container(
            color: Colors.green,
            height: 200,
          )
        ])
      ],
    );
  }
}
