import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import '../cards/white_card.dart';


//La View default de panel administrativo para crear otras View
class BlankView extends StatelessWidget {
  const BlankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Blank View', style: CustomLabels.h1),

          const SizedBox(height: 10),

          //Tarjeta personalizada para mostrar contenido
          const WhiteCard(title: 'Blank View', child: Text('Hola Mundo!!'))
        ],
      ),
    );
  }
}
