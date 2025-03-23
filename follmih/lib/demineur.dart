import 'package:flutter/material.dart';
import 'package:demineur_follmih/screens/start_screen.dart';

class DemineurApp extends StatelessWidget {
  const DemineurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(139, 78, 13, 151),
                  Color.fromARGB(81, 107, 15, 168),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: StartScreen()),
      ),
    );
  }
}
