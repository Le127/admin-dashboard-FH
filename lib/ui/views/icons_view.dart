import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

import '../cards/white_card.dart';

//La View default de panel administrativo para crear otras View
class IconsView extends StatelessWidget {
  const IconsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Icons', style: CustomLabels.h1),
        const SizedBox(height: 10),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          children: const [
            WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(child: Icon(Icons.ac_unit_outlined))),
            WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(child: Icon(Icons.ac_unit_outlined))),
            WhiteCard(
                title: 'access_alarms_outlined',
                width: 170,
                child: Center(child: Icon(Icons.access_alarms_outlined))),
            WhiteCard(
                title: 'emoji_people_outlined',
                width: 170,
                child: Center(child: Icon(Icons.emoji_people_outlined))),
            WhiteCard(
                title: 'heart_broken_rounded',
                width: 170,
                child: Center(child: Icon(Icons.heart_broken_outlined))),
            WhiteCard(
                title: 'volunteer_activism_outlined',
                width: 170,
                child: Center(child: Icon(Icons.volunteer_activism_outlined))),
                  WhiteCard(
                title: 'accessibility_new_rounded',
                width: 170,
                child: Center(child: Icon(Icons.accessibility_new_rounded))),
          ],
        )
      ],
    );
  }
}
