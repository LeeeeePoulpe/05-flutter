import 'package:flutter/material.dart';
import 'package:tp02/modele/modele.dart' as modele;

class GrilleDemineur extends StatefulWidget {
  final int taille, nbMines;
  const GrilleDemineur(
      {required this.taille, required this.nbMines, super.key});
  @override
  State<StatefulWidget> createState() => _GrilleDemineurState();
}

class _GrilleDemineurState extends State<GrilleDemineur> {
  late modele.Grille _grille;
  @override
  void initState() {
    _grille = modele.Grille(taille: widget.taille, nbMines: widget.nbMines);
    super.initState();
  }

  /// construit l’interface du widget//
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.8, // 80% de la largeur de l'écran
        maxHeight: MediaQuery.of(context).size.height *
            0.8, // 60% de la hauteur de l'écran
      ),
      child: AspectRatio(
        aspectRatio: 1.0, // Force un carré parfait
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(), // Désactive le scroll
          crossAxisCount: widget.taille,
          children: List.generate(
            widget.taille * widget.taille,
            (index) {
              int ligne = index ~/ widget.taille;
              int colonne = index % widget.taille;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _grille.mettreAJour(
                      modele.Coup(ligne, colonne, modele.Action.decouvrir),
                    );
                  });
                },
                onLongPress: () {
                  setState(() {
                    _grille.mettreAJour(
                      modele.Coup(ligne, colonne, modele.Action.marquer),
                    );
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: caseToColor(
                        _grille.getCase((ligne: ligne, colonne: colonne))),
                  ),
                  child: Center(
                    child: Text(
                      caseToText(
                        _grille.getCase((ligne: ligne, colonne: colonne)),
                        _grille.isFinie(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Détermine le texte à afficher dans une case en fonctiont de l’état de la partie
  String caseToText(modele.Case laCase, bool isFini) {
    // Si la case n'est pas découverte et le jeu n'est pas fini
    if (laCase.etat != modele.Etat.decouverte && !isFini) {
      // Si la case est marquée, on affiche "?"
      return laCase.etat == modele.Etat.marquee ? "?" : "";
    }

    // Si la case contient une mine
    if (laCase.minee) {
      return "*";
    }

    // Si pas de mines autour, case vide, sinon afficher le nombre
    return laCase.nbMinesAutour == 0 ? "" : "${laCase.nbMinesAutour}";
  }

  /// Détermine la couleur à afficher pour une case
  Color caseToColor(modele.Case laCase) {
    if (laCase.etat != modele.Etat.decouverte) {
      // Case non découverte : bleue si couverte, orange si marquée
      return laCase.etat == modele.Etat.marquee ? Colors.orange : Colors.blue;
    }
    // Case découverte : rouge si minée, grise sinon
    return laCase.minee ? Colors.red : Colors.grey;
  }

  /// Détermine la couleur à afficher pour une case
  String messageEtat(modele.Grille grille) {
    if (grille.isGagnee()) {
      return "Gagné !";
    }
    if (grille.isPerdue()) {
      return "Perdu !";
    }
    return "En cours";
  }
}
