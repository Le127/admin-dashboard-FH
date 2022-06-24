import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';

import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';

import '../buttons/custom_outlined_button.dart';
import '../inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      //Primero se construye lo que este antes del builder. Ahora si tenemos accedo al context para llamar al LoginFormProvider
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      //Usuarios
                      TextFormField(
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su Usuario';
                          }
                          if (value.length < 5) {
                            return 'El usuario debe tener al menos 5 caracteres';
                          }
                          return null; //Válido
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su usuario',
                            label: 'Usuario',
                            icon: Icons.supervised_user_circle_sharp),
                      ),

                      const SizedBox(height: 20),

                      //Email
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? 'xx')) {
                            return 'Email no válido';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su correo',
                            label: 'Email',
                            icon: Icons.email_outlined),
                      ),

                      const SizedBox(height: 20),

                      //Password
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null; //Válido
                        },
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
                        onPressed: () {
                          final validform = registerFormProvider.validateForm();
                          if (validform) {
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            //REGISTER
                            authProvider.register(
                                registerFormProvider.email,
                                registerFormProvider.password,
                                registerFormProvider.name);
                          } else {
                            return;
                          }

                          //Todo authprovider register
                        },
                        text: 'Crear cuenta',
                      ),

                      const SizedBox(height: 20),

                      //Link
                      LinkText(
                        text: 'Ir al login',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Flurorouter.loginRoute);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
