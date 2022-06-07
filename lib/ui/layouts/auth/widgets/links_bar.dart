// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../../buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        color: Colors.black,
        height: (size.width > 1000) ? size.height * 0.07 : null,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 1,
          children: [
            LinkText(text: 'About', onPressed: () => print('click about')),
            LinkText(
                text: 'Help Center',
                onPressed: () =>
                    print('click, deberia redirigirnos a otra page')),
            const LinkText(text: 'Terms of Service'),
            const LinkText(text: 'Privacy Policy'),
            const LinkText(text: 'Cookie Policy'),
            const LinkText(text: 'Blog'),
            const LinkText(text: 'Status'),
            const LinkText(text: 'Carrers'),
            const LinkText(text: 'Brand Resources'),
            const LinkText(text: 'Advertising'),
            const LinkText(text: 'Marketing'),
          ],
        ));
  }
}
