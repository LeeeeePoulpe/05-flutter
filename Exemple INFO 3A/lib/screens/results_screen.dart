import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/model/quiz_question.dart';
import 'package:quiz/widgets/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  // La liste des questions du quiz
  final List<QuizQuestion> theQuestions;
  // La liste des réponses du joueur
  final List<String> chosenAnswers;
  // La méthode du widget Quiz à appeler pour naviguer vers StartScreen
  final void Function() onRestart;

  // Constructeur
  const ResultsScreen({
    super.key,
    required this.theQuestions,
    required this.chosenAnswers,
    required this.onRestart,
  });

  // Retourne la structure de données nécessaire pour afficher les résultats
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': theQuestions[i].text,
          'correct_answer': theQuestions[i].answers[0], // Par convention, la bonne réponse est la 1ère
          'user_answer': chosenAnswers[i]
        },
      );
    }
    return summary;
  }

  // Construction de l'UI du Widget ResultsScreen
  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData(); // La liste des questions/réponses
    final numTotalQuestions = theQuestions.length; // Nombre de questions
    final numCorrectQuestions = summaryData.where((data) {
      // Nombre de bonnes réponses
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vous avez répondu correctement à $numCorrectQuestions question(s) sur $numTotalQuestions',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Recommencer'),
            )
          ],
        ),
      ),
    );
  }
}
