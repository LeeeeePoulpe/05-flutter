import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur_follmih/modele/score_list.dart';
import 'package:demineur_follmih/modele/score.dart';

final scoresListProvider = StateNotifierProvider<ScoresListNotifier, ScoreList>(
    (ref) => ScoresListNotifier());

class ScoresListNotifier extends StateNotifier<ScoreList> {
  ScoresListNotifier() : super(ScoreList.empty()) {
    state.load().whenComplete(() => state = ScoreList(state.scores));
  }

  void addScore(Score newScore) {
    state.scores.add(newScore);
    state = ScoreList(state.scores);
    state.save();
  }

  void addOrUpdateScore(Score newScore) {
    final existingScoreIndex = state.scores.indexWhere((score) =>
        score.id == newScore.id);

    if (existingScoreIndex >= 0) {
      final existingScore = state.scores[existingScoreIndex];

      if (newScore.score > existingScore.score) {
        final updatedScores = List<Score>.from(state.scores);
        updatedScores[existingScoreIndex] = newScore;
        state = ScoreList(updatedScores);
        state.save();
      }
    } else {
      addScore(newScore);
    }
  }

  void removeScore(String id) {
    final scoreToRemove = state.scores.firstWhere((score) => score.id == id);
    state.scores
        .removeAt(state.scores.indexWhere((score) => score == scoreToRemove));
    state = ScoreList(state.scores);
    state.save();
  }
}