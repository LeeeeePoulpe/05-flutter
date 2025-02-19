import 'package:flutter/material.dart';

// Un exemple de Widget personnalisé pour afficher un bouton de réponse
class AnswerButton extends StatelessWidget {
  // Le texte de la réponse
  final String answerText;
  // La méthode du widget QuestionsScreen à appeler quand le bouton est cliqué
  final void Function() onTap;

  // Constructeur
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  // Construction de l'UI du Widget AnswerButton
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child:ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    ));
  }
}
