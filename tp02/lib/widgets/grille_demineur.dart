import 'package:flutter/material.dart';
import 'package:tp02/modele/modele.dart' as modele;

class GrilleDemineur extends StatefulWidget {
  final int taille, nbMines;
  const GrilleDemineur({this.taille, this.nbMines, super.key});
  @override
  State<StatefulWidget> createState() => _GrilleDemineurState();
}

class _GrilleDemineurState extends State<GrilleDemineur> {
  late modele.Grille _grille;
  @override
  void initState() {
    _grille = modele.Grille(widget.taille, widget.nbMines);
    super.initState();
  }

  /// construit l’interface du widget
  @override
  Widget build(BuildContext context) {}

  /// Détermine le texte à afficher dans une case en fonction de l’état de la partie
  String caseToText(modele.Case laCase, bool isFini) {}

  /// Détermine la couleur à afficher pour une case
  Color caseToColor(modele.Case laCase) {}

  /// Détermine la couleur à afficher pour une case
  String messageEtat(modele.Grille grille) {}
}
