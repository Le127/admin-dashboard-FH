import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ListView o sus hijos necesita un tamaño fijo para permitir hacer scroll
      body: ListView(
        children: const [
          //Diseño Desktop
          _DesktopBody()
          //Diseño Mobile

          //Diseño LinksBar
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.red,
      child: Row(
        children: [
          //Imagen pajarito flexible
          Expanded(
            child: Container(color: Colors.blue),
          ),

          //View Container

          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
