import 'package:flutter/material.dart';
import 'package:tp02/modele/modele.dart' as modele;
import 'package:tp02/widgets/case_demineur.dart';

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
    // Calcul de la taille des cases - augmenté pour des cases plus grandes
    // Utilisation d'un facteur 0.9 au lieu de 0.8 pour maximiser l'espace
    double gridSize = MediaQuery.of(context).size.width * 0.9;
    // Limiter la taille maximale pour les grands écrans
    if (gridSize > 500) gridSize = 500;

    double caseSize = (gridSize - 16) / widget.grille.taille; // Soustraire le padding

    // Couleurs dans le style Shadcn
    final borderColor = Colors.grey.shade200;
    final backgroundColor = Colors.white;

    return Container(
      constraints: BoxConstraints(
        maxWidth: gridSize,
        maxHeight: gridSize,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: widget.grille.taille,
          mainAxisSpacing: 4, // Espacement augmenté
          crossAxisSpacing: 4, // Espacement augmenté
          padding: const EdgeInsets.all(0), // Pas de padding interne pour maximiser l'espace
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
