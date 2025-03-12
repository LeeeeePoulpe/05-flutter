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
  late int _score;
  late double _temps;
  late modele.Grille grille;

  @override
  void initState() {
    grille = modele.Grille(
      taille: widget.tailleFromStartScreen,
      nbMines: widget.nbMinesFromStartScreen,
    );
    super.initState();
  }

  void endGame(int score, double temps) {
    setState(() {
          _score = score;
          _temps = temps;
    });
  }

  void play(modele.Coup coup){
    setState(() {
      grille.mettreAJour(coup);
    });
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
            GrilleDemineur(
              grille: grille,
              play: play,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Opacity(
                opacity: grille.isFinie() ? 1.0 : 0.0,
                child: OutlinedButton.icon(
                  onPressed: grille.isFinie() ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          score: _score,
                          temps: _temps,
                        ),
                      ),
                    );
                  } : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple.withOpacity(0.3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text('Voir les résultats', style: TextStyle(fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
