import 'package:admin_dashboard/providers/sidemenu_provider.dart';
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

class _DashBoardLayoutState extends State<DashBoardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    //Inicializa el controlador, ya que en el provider no lo hace.
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              //Barra lateral con 200px reservados
              if (size.width >= 700) const Sidebar(),

              //Esta Column contiene el NavBar y la View que se va a mostrar basada en el url que tenga.
              //Va a utilizar el total de los px restantes
              Expanded(
                child: Column(
                  children: [
                    //NavBar
                    const NavBar(),

                    //View.
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              )
            ],
          ),
          if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  //Todo background sideBar animation
                  if (SideMenuProvider.isOpen)
                    Opacity(
                      opacity: SideMenuProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),

                  Transform.translate(
                    offset: Offset(SideMenuProvider.movement.value, 0),
                    child: const Sidebar(),
                  )
                ],
              ),
            ),
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
