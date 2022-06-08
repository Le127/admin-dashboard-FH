import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

import '../buttons/custom_outlined_button.dart';
import '../inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 370),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    // validator: (),

                    //Usuarios
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su usuario',
                        label: 'Usuario',
                        icon: Icons.supervised_user_circle_sharp),
                  ),

                  const SizedBox(height: 20),

                  //Email
                  TextFormField(
                    // validator: (),
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Email',
                        icon: Icons.email_outlined),
                  ),

                  const SizedBox(height: 20),

                  //Password
                  TextFormField(
                    // validator: (),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: '******',
                        label: 'Contraseña',
                        icon: Icons.lock_outline_rounded),
                  ),

                  const SizedBox(height: 20),

                  //Button Register
                  CustomOutlinedButton(
                    onPressed: () {},
                    text: 'Crear cuenta',
                  ),

                  const SizedBox(height: 20),

                  //Link
                  LinkText(
                    text: 'Ir al login',
                    onPressed: () {
                      Navigator.pushNamed(context, Flurorouter.loginRoute);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
