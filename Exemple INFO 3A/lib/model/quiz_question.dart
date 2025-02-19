// Classe pour représenter une question du Quiz
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text; // La question
  final List<String> answers; // Les réponses

  // Retourne la liste des réponses mélangées aléatoirement
  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}

// Les données du Quiz : une liste d'objets QuizQuestion
// Parmi les réponses proposées à une question, la 1ère est la bonne

const List<QuizQuestion> questions = [
  QuizQuestion(
    'Quels sont les éléments qui composent une UI Flutter ?',
    [
      'Widgets',
      'Composants',
      'Blocs',
      'Fonctions',
    ],
  ),
  QuizQuestion('Comment une UI Flutter est-elle réalisée ?', [
    'En combinant des widgets dans le code',
    'En combinant des widgets dans un éditeur WYSIWYG',
    'En déclarant des widgets dans un fichier de configuration',
    'En utilisant XCode pour iOS et Android Studio pour Android',
  ]),
  QuizQuestion(
    'Quel est le but d\'un StatefulWidget?',
    [
      'Mettre à jour l\'UI quand les données changent',
      'Mettre à jour les données quand l\'UI change',
      'Ignorer les changements de données',
      'Afficher une UI qui ne dépend pas de données',
    ],
  ),
  QuizQuestion(
    'Pour les performances, quel widget privilégier : StatelessWidget ou StatefulWidget ?',
    [
      'StatelessWidget',
      'StatefulWidget',
      'Les deux se valent',
      'Aucun',
    ],
  ),
  QuizQuestion(
    'Que se passe-t-il si les données d\'un StatelessWidget sont modifiées ?',
    [
      'L\'UI n\'est pas mise à jour',
      'L\'UI est mise à jour',
      'Le StatefulWidget le plus proche est mis à jour',
      'Tous les StatefulWidgets imbriqués sont mis à jour',
    ],
  ),
  QuizQuestion(
    'Comment modifier les données d\'un StatefulWidget ?',
    [
      'En appelant setState()',
      'En appelant updateData()',
      'En appelant updateUI()',
      'En appelant updateState()',
    ],
  ),
];
