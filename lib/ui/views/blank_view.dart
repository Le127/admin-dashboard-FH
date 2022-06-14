import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import '../cards/white_card.dart';


//La View default de panel administrativo para crear otras View
class BlankView extends StatelessWidget {
  const BlankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Blank View', style: CustomLabels.h1),

        const SizedBox(height: 10),

        //Tarjeta personalizada para mostrar contenido
        const WhiteCard(title: 'Sales Statistics', child: Text('Hola Mundo'))
      ],
    );
  }
}
