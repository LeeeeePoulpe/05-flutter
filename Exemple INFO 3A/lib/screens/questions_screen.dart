import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/widgets/answer_button.dart';
import 'package:quiz/model/quiz_question.dart';

// Widget pour afficher l'écran qui pose une question
class QuestionsScreen extends StatefulWidget {
  // Questions du Quiz
  final  List<QuizQuestion> theQuestions;
  // La méthode à appeler pour mettre à jour l'état du Widget Quiz lors d'une réponse
  //  c'est-à-dire pour enregistrer une nouvelle réponse
  final void Function(String answer) onSelectAnswer;

  // Constructeur
  const QuestionsScreen({
    super.key,
    required this.theQuestions,
    required this.onSelectAnswer,
  });

  // Création de l'état associé au widget QuestionScreen
  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

// L'état associé au widget Quiz
class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0; // le numéro de la question à afficher

  void answerQuestion(String selectedAnswer) {
    // On appelle la méthode transmise par le widget parent Quiz
    widget.onSelectAnswer(
        selectedAnswer); // rappel : widget est le Stateful Widget QuestionScreen associé à l'état
    setState(() {
      currentQuestionIndex++; // on passe à la question suivante
    });
  }

  // Construction de l'UI du Widget QuestionsScreen
  @override
  Widget build(context) {
    // On récupère la question courante
    final QuizQuestion currentQuestion = widget.theQuestions[currentQuestionIndex];
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // liste de AnswerButtons fabriquée à partir de la liste des réponses,
            // en utilisant la méthode map, et en appliquant l'opérateur spread (...)
            // sur le résultat de map pour pouvoir les ajouter à la liste des children
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
