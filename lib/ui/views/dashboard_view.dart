import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import '../cards/white_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('DashboardView', style: CustomLabels.h1),

          const SizedBox(height: 10),

          //Tarjeta personalizada para mostrar contenido
          const WhiteCard(title: 'Sales Statistics', child: Text('Hola Mundo'))
        ],
      ),
    );
  }
}
