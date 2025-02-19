import 'package:flutter/material.dart';
import 'package:tp02/widgets/grille_demineur.dart';

class GameScreen extends StatelessWidget {
  final int taille;
  final int nbMines;
  final void Function(int score, double temps) endGame;

  const GameScreen({
    required this.taille,
    required this.nbMines,
    required this.endGame,
    Key? key,
  }) : super(key: key);

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
              taille: taille,
              nbMines: nbMines,
            ),
          ],
        ),
      ),
    );
  }
}
