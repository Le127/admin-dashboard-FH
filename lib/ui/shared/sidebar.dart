import 'package:flutter/material.dart';

import 'widgets/custom_menu_item.dart';
import 'widgets/logo.dart';
import 'widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children:  [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          CustomMenuItem(
              text: 'Dashboard',
              icon: Icons.compass_calibration_outlined,
              isActive: false,
              onPressed: () => print('Dashboard')),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff092044),
            Color(
              0xff092042,
            )
          ],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10),
        ],
      );
}
