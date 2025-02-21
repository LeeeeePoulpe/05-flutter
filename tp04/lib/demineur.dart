import 'package:flutter/material.dart';
import 'package:tp02/screens/start_screen.dart';

class DemineurApp extends StatelessWidget {
  const DemineurApp({Key? key}) : super(key: key);

  // Widget screenToShow() {
  //   setState(() {}); // Pour forcer la mise à jour de l'interface
  //   switch (_etat) {
  //     case Etat.result:
  //       return ResultScreen(
  //         score: _score,
  //         temps: _temps.toInt(),
  //         restartGame: restartGame,
  //       );
  //   }
  // }

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
