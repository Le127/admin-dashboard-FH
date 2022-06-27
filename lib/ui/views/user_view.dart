import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
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
          //AVATAR
          _AvatarContainer(),

          //Formulario Actualización

          const _UserViewForm()
        ])
      ],
    );
  }
}

// UserViewForm
class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: 'Información general',
      child: Form(
        //TODO: Key
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            //Nombre
            TextFormField(
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Nombre del usuario',
                  label: 'Nombre',
                  icon: Icons.supervised_user_circle_outlined),
            ),

            const SizedBox(height: 20),

            //Email
            TextFormField(
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Correo del usuario',
                  label: 'Correo',
                  icon: Icons.mark_email_read_outlined),
            ),

            const SizedBox(height: 20),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 108),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.save_outlined, size: 20),
                    Text(' Guardar')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// AvatarContainer
class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: CustomLabels.h2,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  const ClipOval(
                    child: Image(
                      image: AssetImage('no-image.jpg'),
                    ),
                  ),

                  //Linea blanca al rededor del FAB
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      // FAB
                      child: FloatingActionButton(
                        onPressed: () {
                          //TODO: seleccionar imagen
                        },
                        backgroundColor: Colors.indigo,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nombre de usuario',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
