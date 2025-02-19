import 'package:flutter/material.dart';
import 'package:quiz/model/quiz_question.dart';
import 'package:quiz/screens/start_screen.dart';
import 'package:quiz/screens/questions_screen.dart';
import 'package:quiz/screens/results_screen.dart';

// Widget principal qui gère l'état de toute l'application
// et affiche soit StartScreen, soit QuestionsScreen, soit ResultsScreen
class Quiz extends StatefulWidget {
  // Contructeur
  const Quiz({super.key});
  // Instanciation de l'état _QuizState associé au widget Quiz
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// Les différents types de Screen à afficher
enum ScreenState { start, questions, results }

// L'état associé au widget Quiz
class _QuizState extends State<Quiz> {
  // Les questions du Quiz
  final theQuestions=List<QuizQuestion>.from(questions);
  // La liste des réponses sélectionnés par le joueur
  final List<String> selectedAnswers = [];
  // Pour savoir quel widget afficher
  ScreenState screenState = ScreenState.start;
  // StopWatch
  final stopWatch=Stopwatch();

  // Méthode appelée depuis StartScreen pour "naviguer" vers QuestionsScreen
  void startQuiz() {
    setState(() {
      selectedAnswers.clear(); // on vide la liste des réponses
      theQuestions.shuffle(); // on mélange les questions aléatoirement
      screenState = ScreenState.questions; // on va afficher QuestionScreen
    });
  }

  // Méthode appelée depuis QuestionsScreen pour enregistrer une nouvelle réponse
  // et "naviguer" vers ResultsScreen si toutes les réponses ont été données
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      // Si toutes les réponses...
      setState(() {
        screenState = ScreenState.results; // on va afficher ResultsScreen
      });
    }
  }

  // Méthode appelée depuis ResultsScreen pour "naviguer" vers StartScreen
  void reStartQuiz() {
    setState(() {
      screenState = ScreenState.start; // On va afficher StartScreen
    });
  }

  // Retourne le widget à afficher selon l'état (valeur de screenState)
  Widget chooseScreenWidget() {
    switch (screenState) {
      case ScreenState.start:
        {
          return StartScreen(startQuiz);
        }
      case ScreenState.questions:
        {
          return QuestionsScreen(
            theQuestions: theQuestions,
            onSelectAnswer: chooseAnswer,
          );
        }
      case ScreenState.results:
        {
          return ResultsScreen(
            theQuestions: theQuestions,
            chosenAnswers: selectedAnswers,
            onRestart: reStartQuiz,
          );
        }
    }
  }

  // Construction de l'UI du Widget Quiz
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(139, 78, 13, 151),
                Color.fromARGB(81, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: chooseScreenWidget(),
        ),
      ),
    );
  }
}
