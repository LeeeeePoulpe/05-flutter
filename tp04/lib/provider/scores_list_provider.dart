import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/modele/score_list.dart';
import 'package:tp02/modele/score.dart';

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

  void removeScore(String id) {
    final scoreToRemove = state.scores.firstWhere((score) => score.id == id);
    state.scores.removeAt(state.scores.indexWhere((score) => score == scoreToRemove));
    state = ScoreList(state.scores);
    state.save();
  }
}