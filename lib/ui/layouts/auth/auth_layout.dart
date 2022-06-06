import 'package:flutter/material.dart';

import 'widgets/background_twitter.dart';
import 'widgets/custom_title.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ListView o sus hijos necesita un tamaño fijo para permitir hacer scroll
      body: ListView(
        children: [
          //Diseño Desktop
          _DesktopBody(child: child)
          //Diseño Mobile

          //Diseño LinksBar
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Adapta el tamaño segun la pantalla
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.red,
      child: Row(
        children: [
          //Imagen pajarito flexible
          //Container flexible dependiendo el tamaño de la pantalla
          const BackgroundTwitter(),

          //View Container
          //Cointainer de ancho fijo.

          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(child: child)
              ],
            ),
            //child: La View correcta. ,
          )
        ],
      ),
    );
  }
}
