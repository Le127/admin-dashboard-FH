import 'package:flutter/material.dart';

import 'widgets/background_twitter.dart';
import 'widgets/custom_title.dart';
import 'widgets/links_bar.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //ListView o sus hijos necesita un tamaño fijo para permitir hacer scroll
      body: Scrollbar(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            //Si el width es mayor a 1000 muestra Desktop, caso contrario Mobile
            (size.width > 1000)
                ? _DesktopBody(child: child)
                : _MobileBody(child: child),

            //Diseño LinksBar
            const LinksBar(),
          ],
        ),
      ),
    );
  }
}

//Diseño Desktop
class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Adapta el tamaño segun la pantalla
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: Colors.red,
      child: Row(
        children: [
          //Container flexible dependiendo el tamaño de la pantalla
          const BackgroundTwitter(),

          //View Container de ancho fijo.
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

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomTitle(),
          //View
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: BackgroundTwitter(),
          )
        ],
      ),
    );
  }
}
