import 'package:flutter/material.dart';
import 'package:tp02/modele/modele.dart' as modele;
import 'package:tp02/widgets/case_demineur.dart'; // Import the new CaseWidget

class GrilleDemineur extends StatefulWidget {
  final modele.Grille grille;
  final Function(modele.Coup) play;
  const GrilleDemineur({required this.grille, required this.play, super.key});
  @override
  State<StatefulWidget> createState() => _GrilleDemineurState();
}

class _GrilleDemineurState extends State<GrilleDemineur> {
  VoidCallback blockClicks(VoidCallback callback) {
    return widget.grille.isFinie() ? () {} : callback;
  }

  @override
  Widget build(BuildContext context) {
    double caseSize =
        MediaQuery.of(context).size.width * 0.8 / widget.grille.taille;

    return Container(
      margin: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: widget.grille.taille,
          children: List.generate(
            widget.grille.taille * widget.grille.taille,
            (index) {
              int ligne = index ~/ widget.grille.taille;
              int colonne = index % widget.grille.taille;
              return CaseWidget(
                size: caseSize,
                cell: widget.grille.getCase((ligne: ligne, colonne: colonne)),
                isFini: widget.grille.isFinie(),
                onTap: blockClicks(() {
                  widget.play(
                      modele.Coup(ligne, colonne, modele.Action.decouvrir));
                }),
                onLongPress: blockClicks(() {
                  widget.play(
                      modele.Coup(ligne, colonne, modele.Action.marquer));
                }),
              );
            },
          ),
        ),
      ),
    );
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
