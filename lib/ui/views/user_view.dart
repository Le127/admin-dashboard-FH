import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

import '../../models/usuario.dart';
import '../../providers/providers.dart';

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
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid).then(
      (userDB) {
        if (userDB != null) {
          //Asigna el usuario al Provider
          userFormProvider.user = userDB;
          //Inicializa nuevamente el Key. Lo limpia.
          userFormProvider.formKey = GlobalKey<FormState>();
          setState(() {
            user = userDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/users');
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    user = null;

    Provider.of<UserFormProvider>(context, listen: false).user = null;

    super.dispose();
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
          //Formulario Actualizaci??n
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
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    return WhiteCard(
      title: 'Informaci??n general',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            //Nombre
            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Nombre del usuario',
                  label: 'Nombre',
                  icon: Icons.supervised_user_circle_outlined),
              onChanged: (value) {
                userFormProvider.copyUserWith(nombre: value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) return 'Ingrese un nombre';
                if (value.length < 2) {
                  return 'El nombre debe tener dos letras como minimo';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //Email
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Correo del usuario',
                  label: 'Correo',
                  icon: Icons.mark_email_read_outlined),
              onChanged: (value) =>
                  userFormProvider.copyUserWith(correo: value),
              validator: (value) {
                if (!EmailValidator.validate(value ?? 'xx')) {
                  return 'Email no v??lido';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //BOTON ACTUALIZAR
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 115, maxHeight: 40),
              child: ElevatedButton(
                onPressed: () async {
                  final saved = await userFormProvider.updateUser();
                  if (saved) {
                    NotificationsService.showSnackbarOk('Usuario actualizado');
                    usersProvider.refreshUser(user);
                  } else {
                    NotificationsService.showSnackbarError(
                        'No se pudo guardar');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save_outlined, size: 20),
                    Text('Actualizar')
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
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    final usersProvider = Provider.of<UsersProvider>(context);

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
                  ClipOval(
                    child: (user.img == null)
                        ? const Image(
                            image: AssetImage('no-image.jpg'),
                          )
                        : FadeInImage.assetNetwork(
                            placeholder: 'loader.gif', image: user.img!),
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
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                                  allowMultiple: false);

                          if (result != null) {
                            PlatformFile file = result.files.first;
                            // ignore: use_build_context_synchronously
                            NotificationsService.showBusyIndicator(context);

                            final newUser = await userFormProvider.uploadImage(
                                '/uploads/usuarios/${user.uid}', file.bytes!);

                            usersProvider.refreshUser(newUser);

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          } else {
                            // User canceled the picker

                            print('No hay imagen');
                          }
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
            Text(
              user.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
