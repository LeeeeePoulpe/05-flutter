import 'package:flutter/material.dart';
import 'package:tp02/screens/result_screen.dart';
import 'package:tp02/widgets/grille_demineur.dart';
import 'package:tp02/modele/modele.dart' as modele;

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
  late modele.Grille grille;

  @override
  void initState() {
    super.initState();
    grille = modele.Grille(
      taille: widget.tailleFromStartScreen,
      nbMines: widget.nbMinesFromStartScreen,
    );
  }

  // Calcule le score basé sur le temps et la difficulté
  int _calculateScore() {
    int baseScore = widget.nbMinesFromStartScreen * 100;
    int chrono = grille.getChrono();
    int timeBonus = chrono < 60 ? (60 - chrono) * 10 : 0;
    return baseScore + timeBonus;
  }

  void play(modele.Coup coup) {
    setState(() {
      grille.mettreAJour(coup);
    });
  }

  String messageEtat(modele.Grille grille) {
    if (grille.isGagnee()) {
      return "Gagné !";
    }
    if (grille.isPerdue()) {
      // return "Perdu !";
      return _calculateScore().toString();
    }
    return "En cours";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              messageEtat(grille),
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            GrilleDemineur(
              grille: grille,
              play: play,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Opacity(
                opacity: grille.isFinie() ? 1.0 : 0.0,
                child: OutlinedButton.icon(
                  onPressed: grille.isFinie()
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                score: _calculateScore(),
                                temps: grille.getChrono().toDouble(),
                                message: messageEtat(grille),
                              ),
                            ),
                          );
                        }
                      : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text('Voir les résultats',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
