import 'package:flutter/material.dart';
import 'package:tp02/widgets/grille_demineur.dart';

class GameScreen extends StatefulWidget {
  final int tailleFromStartScreen;
  final int nbMinesFromStartScreen;

  const GameScreen({
    required this.tailleFromStartScreen,
    required this.nbMinesFromStartScreen,
    Key? key,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int _score;
  late double _temps;

  void endGame(int score, double temps) {
    _score = score;
    _temps = temps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Démineur',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            GrilleDemineur(
              taille: widget.tailleFromStartScreen,
              nbMines: widget.nbMinesFromStartScreen,
            ),
          ],
        ),
      ),
    );
  }
}
