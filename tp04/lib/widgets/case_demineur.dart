import 'package:flutter/material.dart';
import 'package:tp02/modele/modele.dart' as modele;

class CaseWidget extends StatelessWidget {
  final double size;
  final modele.Case cell;
  final bool isFini;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CaseWidget({
    required this.size,
    required this.cell,
    required this.isFini,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  String getCaseText() {
    if (cell.etat != modele.Etat.decouverte && !isFini) {
      return cell.etat == modele.Etat.marquee ? "?" : "";
    }
    if (cell.minee) {
      return "*";
    }
    return cell.nbMinesAutour == 0 ? "" : "${cell.nbMinesAutour}";
  }

  Color getCaseColor() {
    if (cell.etat != modele.Etat.decouverte) {
      return cell.etat == modele.Etat.marquee ? Colors.orange : Colors.blue;
    }
    return cell.minee ? Colors.red : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: getCaseColor(),
        border: Border.all(),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Center(
            child: Text(
              getCaseText(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cell.etat == modele.Etat.decouverte ? Colors.indigo[900] : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
