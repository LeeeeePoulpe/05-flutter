import 'package:flutter/material.dart';
import 'package:tp02/screens/result_screen.dart';
import 'package:tp02/widgets/grille_demineur.dart';
import 'package:tp02/modele/modele.dart' as modele;

class GameScreen extends StatefulWidget {
  final int tailleFromStartScreen;
  final int nbMinesFromStartScreen;
  final String playerName;

  const GameScreen({
    required this.tailleFromStartScreen,
    required this.nbMinesFromStartScreen,
    this.playerName = '',
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
      return "Perdu !";
    }
    return "En cours";
  }

  @override
  Widget build(BuildContext context) {
    // Couleurs dans le style Shadcn
    final backgroundColor = Colors.grey.shade50;
    final textColor = Color(0xFF1A1523);
    final primaryColor = Color(0xFF6E56CF);

    // Déterminer la couleur d'état en fonction du statut du jeu
    final bool isGameWon = grille.isGagnee();
    final statusColor = isGameWon
        ? Color(0xFF4ADE80)
        : grille.isPerdue()
            ? Color(0xFFF43F5E)
            : primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Démineur',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bannière d'état du jeu
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isGameWon
                        ? Icons.emoji_events
                        : grille.isPerdue()
                            ? Icons.dangerous
                            : Icons.timer,
                    color: statusColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    messageEtat(grille),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Grille de jeu
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: GrilleDemineur(
                grille: grille,
                play: play,
              ),
            ),

            // Bouton de résultats
            AnimatedOpacity(
              opacity: grille.isFinie() ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: ElevatedButton(
                  onPressed: grille.isFinie()
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                score: _calculateScore(),
                                temps: grille.getChrono().toDouble(),
                                message: isGameWon
                                    ? "Bravo ${widget.playerName}! Vous avez gagné!"
                                    : "Dommage ${widget.playerName}, vous avez perdu!",
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Voir les résultats',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
