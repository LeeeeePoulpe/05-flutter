import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur_follmih/modele/score.dart';
import 'package:demineur_follmih/provider/scores_list_provider.dart';
import 'package:demineur_follmih/screens/result_screen.dart';
import 'package:demineur_follmih/widgets/grille_demineur.dart';
import 'package:demineur_follmih/modele/modele.dart' as modele;

class GameScreen extends ConsumerStatefulWidget {
  final int tailleFromStartScreen;
  final int nbMinesFromStartScreen;
  final String playerName;
  final bool cheatModeEnabled;
  final String difficulty;

  const GameScreen({
    required this.tailleFromStartScreen,
    required this.nbMinesFromStartScreen,
    required this.cheatModeEnabled,
    required this.difficulty,
    this.playerName = '',
    Key? key,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late modele.Grille grille;
  bool cheatModeEnabled = false;

  @override
  void initState() {
    super.initState();
    grille = modele.Grille(
      taille: widget.tailleFromStartScreen,
      nbMines: widget.nbMinesFromStartScreen,
    );
    cheatModeEnabled = widget.cheatModeEnabled;
  }

  // Calcule le nombre de mines restantes (non marquées)
  int _getMinesRestantes() {
    int casesMarquees = 0;

    for (int lig = 0; lig < grille.taille; lig++) {
      for (int col = 0; col < grille.taille; col++) {
        final coord = (ligne: lig, colonne: col);
        final maCase = grille.getCase(coord);

        if (maCase.etat == modele.Etat.marquee) {
          casesMarquees++;
        }
      }
    }

    return grille.nbMines - casesMarquees;
  }

  void _revelerToutesLesCasesNonMinees() {
    setState(() {
      for (int lig = 0; lig < grille.taille; lig++) {
        for (int col = 0; col < grille.taille; col++) {
          final coord = (ligne: lig, colonne: col);

          final maCase = grille.getCase(coord);

          if (!maCase.minee) {
            maCase.decouvrir();
          }
        }
      }
    });
  }

  // Calcule le score basé sur le temps et la difficulté
  int _calculateScore() {
    if (grille.isPerdue()) {
      return 0;
    }

    double tempsEnSecondes = grille.getChrono();

    double coeffTemps = 1000.0 * exp(-tempsEnSecondes / 60.0);

    double coeffDifficulte = (grille.nbMines / grille.nbCases) * grille.taille;

    int score = (coeffTemps * coeffDifficulte).toInt();

    return score;
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

  void setNewScore() {
    if (grille.isGagnee()) {
      ref.watch(scoresListProvider.notifier).addOrUpdateScore(Score(
          playerName: widget.playerName,
          score: _calculateScore(),
          difficulty: widget.difficulty,
          chrono: grille.getChrono(),
          date: DateTime.now()));
    }
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

    // Calculer la largeur maximale pour les écrans larges
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final contentWidth = isLargeScreen ? 600.0 : screenWidth;

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
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: contentWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Informations sur le joueur
              if (widget.playerName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Joueur: ${widget.playerName}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              // Bannière d'état du jeu et compteur de mines dans une ligne
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bannière d'état du jeu
                    Container(
                      width: 140, // Largeur fixe plus petite
                      margin: const EdgeInsets.only(right: 8, bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Compteur de mines restantes
                    Container(
                      width: 140, // Largeur fixe plus petite
                      margin: const EdgeInsets.only(left: 8, bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flag,
                            color: Color(0xFFF59E0B), // Couleur ambre
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Mines: ${_getMinesRestantes()}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (cheatModeEnabled)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    width: isLargeScreen ? 400 : double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _revelerToutesLesCasesNonMinees();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFFF43F5E), // Rouge
                        backgroundColor: Color(0xFFFFF1F2), // Rouge très pâle
                        side:
                            BorderSide(color: Color(0xFFFECDD3)), // Rouge clair
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      icon: Icon(
                        Icons.auto_fix_high,
                        size: 18,
                      ),
                      label: Text(
                        'Révéler les cases non minées',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
                  child: Container(
                    width: isLargeScreen ? 400 : double.infinity,
                    child: ElevatedButton(
                      onPressed: grille.isFinie()
                          ? () {
                              setNewScore();
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
                        elevation: 2,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
