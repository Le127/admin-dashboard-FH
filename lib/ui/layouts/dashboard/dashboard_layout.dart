import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DashBoard',
              style: TextStyle(fontSize: 50),
            ),
            Expanded(child: widget.child)
          ],
        ),
      ),
    );
  }
}
