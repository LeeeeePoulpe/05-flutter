import 'package:flutter/material.dart';
import 'package:tp02/screens/start_screen.dart';
import 'package:tp02/screens/game_screen.dart';
import 'package:tp02/screens/result_screen.dart';
import 'package:tp02/modele/modele.dart' as modele; // Ajout de l'import

enum Etat { start, game, result }

class DemineurApp extends StatefulWidget {
  const DemineurApp({super.key});

  @override
  State<StatefulWidget> createState() => _DemineurApp();
}

class _DemineurApp extends State<DemineurApp> {
  late Etat _etat;
  late int _nbMines, _taille;
  late int _score;
  late double _temps;
  late modele.Grille _grille; // Ajout de la propriété grille

  @override
  void initState() {
    super.initState();
    _etat = Etat.start;
  }

  void startGame(int taille, int nbMines) {
    setState(() {
      _taille = taille;
      _nbMines = nbMines;
      _grille = modele.Grille(
          taille: taille, nbMines: nbMines); // Initialisation de la grille
      _etat = Etat.game;
    });
  }

  void endGame(int score, double temps) {
    _score = score;
    _temps = temps;
    _etat = Etat.result;
  }

  void restartGame() {
    _etat = Etat.start;
  }

  Widget screenToShow() {
    setState(() {}); // Pour forcer la mise à jour de l'interface
    switch (_etat) {
      case Etat.start:
        return StartScreen(startGame: startGame);
      case Etat.game:
        return GameScreen(
          taille: _taille,
          nbMines: _nbMines,
          endGame: endGame,
        );
      case Etat.result:
        return ResultScreen(
          score: _score,
          temps: _temps.toInt(),
          restartGame: restartGame,
        );
    }
  }

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
          child: screenToShow(),
        ),
      ),
    );
  }
}
