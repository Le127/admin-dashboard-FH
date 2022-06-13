import 'package:flutter/material.dart';

import 'widgets/navbar_avatar.dart';
import 'widgets/notification_indicator.dart';
import 'widgets/search_text.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          // todo: Icono del Menu dependiendo del responsive

          //MenuIcon
          IconButton(icon: const Icon(Icons.menu_outlined), onPressed: () {}),
          const SizedBox(width: 5),

          //SearchBox. Limita el crecimiento del widget
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: const SearchText(),
          ),
          //Spacer
          const Spacer(),

          //Notificacion
          const NotificationIndicator(),

          const SizedBox(width: 10),

          //Avatar
          const NavbarAvatar(),

          const SizedBox(width: 10),
        ],
      ),
    );
  }

//Color y sombra
  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
