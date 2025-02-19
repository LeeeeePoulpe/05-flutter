import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/widgets/questions_summary/question_identifier.dart';

// Widget pour afficher le résultat d'une réponse
class SummaryItem extends StatelessWidget {
  //   String itemData['question'] : la question
  //   String itemData['user_answer'] : réponse donnée par l'utilisateur
  //   String itemData['correct_answer'] : la bonne réponse
  //   int    itemData['question_index'] : le numéro de la question
  final Map<String, Object> itemData;

  // Constructeur
  const SummaryItem(this.itemData, {super.key});

  // Construction de l'UI du Widget SummmaryItem
  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
            isCorrectAnswer: isCorrectAnswer,
            questionIndex: itemData['question_index'] as int,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['question'] as String,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Réponse : ${itemData['correct_answer']}',
                    style: const TextStyle(
                      color: Colors.white,
                    )),
                Text(
                    isCorrectAnswer
                        ? 'Vous avez bien répondu'
                        : 'Erreur, vous avez dit : ${itemData['user_answer']}',
                    style: TextStyle(
                      color: isCorrectAnswer ? Colors.teal : Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
