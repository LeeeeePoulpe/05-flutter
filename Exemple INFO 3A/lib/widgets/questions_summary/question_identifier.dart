import 'package:flutter/material.dart';

// Widget pour afficher le badge du numéro de question
// Vert si réponse correcte, Rouge sinon
class QuestionIdentifier extends StatelessWidget {
  // Le numéro de la question
  final int questionIndex;
  // Justesse de la réponse
  final bool isCorrectAnswer;

  // Constructeur
  const QuestionIdentifier({
    super.key,
    required this.isCorrectAnswer,
    required this.questionIndex,
  });

  // Construction de l'UI du Widget QuestionIdentifier
  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCorrectAnswer
            ? Colors.teal
            : Colors.pink,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        questionNumber.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
