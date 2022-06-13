import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

import '../../shared/navbar.dart';

//Dashboard Principal que muestra la barra lateral y una view.

class DashBoardLayout extends StatefulWidget {
  //El view que va  a mostrar
  final Widget child;

  const DashBoardLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Row(
        children: [
          //Barra lateral con 200px reservados
          const Sidebar(),

          //Esta Column contiene el NavBar y la View que se va a mostrar basada en el url que tenga.
          //Va a utilizar el total de los px restantes
          Expanded(
            child: Column(
              children: [
                //NavBar
                const NavBar(),

                //View.
                Expanded(child: widget.child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
/* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DashBoard',
              style: TextStyle(fontSize: 50),
            ),
            //View
            Expanded(
              child: Container(
                color: Colors.white,
                child: widget.child,
              ),
            )
          ],
        ),
      ), */
