import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';

import '../../providers/login_form_provider.dart';
import '../buttons/custom_outlined_button.dart';
import '../inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      //Primero se construye lo que este antes del builder. Ahora si tenemos accedo al context para llamar al LoginFormProvider
      child: Builder(builder: (context) {
        final loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);

        return Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              //Formulario
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: loginFormProvider.formKey,
                child: Column(
                  children: [
                    //Email
                    TextFormField(
                      onFieldSubmitted: (_) =>
                          onFormSubmit(loginFormProvider, authProvider),
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? 'xx')) {
                          return 'Email no válido';
                        }
                        return null;
                      },
                      onChanged: (value) => loginFormProvider.email = value,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su correo',
                          label: 'Email',
                          icon: Icons.email_outlined),
                    ),

                    const SizedBox(height: 20),

                    //Password
                    TextFormField(
                      onFieldSubmitted: (_) =>
                          onFormSubmit(loginFormProvider, authProvider),
                      onChanged: (value) => loginFormProvider.password = value,
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

                    //Button Login
                    CustomOutlinedButton(
                      onPressed: () =>
                          onFormSubmit(loginFormProvider, authProvider),
                      text: 'Ingresar',
                    ),

                    const SizedBox(height: 20),

                    //Link
                    LinkText(
                      text: 'Nueva Cuenta',
                      onPressed: () {
                        Navigator.pushNamed(context, Flurorouter.registerRoute);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void onFormSubmit(
      LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid) {
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
    }
  }
}
