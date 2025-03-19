import 'package:flutter/material.dart';
import 'package:tp02/modele/modele.dart' as modele;

class CaseWidget extends StatelessWidget {
  final modele.Case cell;
  final double size;
  final bool isFini;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CaseWidget({
    required this.cell,
    required this.size,
    required this.isFini,
    required this.onTap,
    required this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Couleurs complètement nouvelles et très distinctes
    final borderColor = Colors.grey.shade400;

    // Couleurs très contrastées
    final nonRevealedColor = Color(0xFF6E56CF); // Violet
    final revealedColor = Color(0xFFE2E8F0); // Gris clair
    final markedColor = Color(0xFFF59E0B); // Orange vif
    final mineColor = Color(0xFFEF4444); // Rouge vif

    // Déterminer l'apparence de la case
    final bool isRevealed = cell.etat == modele.Etat.decouverte;
    final bool isMarked = cell.etat == modele.Etat.marquee;

    // Couleur de la case selon son état
    Color caseColor;
    if (isRevealed) {
      caseColor = cell.minee ? mineColor : revealedColor;
    } else {
      caseColor = isMarked ? markedColor : nonRevealedColor;
    }
    
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: caseColor,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: isMarked
              ? Icon(
                  Icons.flag,
                  color: Colors.white,
                  size: size * 0.6,
                )
              : isRevealed && cell.minee
                  ? Icon(
                      Icons.dangerous,
                      color: Colors.white,
                      size: size * 0.6,
                    )
                  : const SizedBox(),
        ),
      ),
    );
  }
}
