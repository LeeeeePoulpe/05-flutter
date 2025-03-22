import 'dart:convert';

import 'package:tp02/modele/score.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreList {
  List<Score> scores;
  static const scoresKey = 'scores_list';

  List<Score> get list => scores;

  ScoreList(this.scores);

  ScoreList.empty() : scores = [];

  // Charge la liste des scores depuis le local storage
  Future<void> load()async {
    final localStorage = await SharedPreferences.getInstance();

    List<String> jsonScores = localStorage.getStringList(scoresKey) ?? [];

    scores = jsonScores
    .map((jsonScore) => Score.fromJson(jsonDecode(jsonScore)))
    .toList();
  }

  // Sauvegarde la liste des scores dans le local storage
  Future<void> save() async {
    final localStorage = await SharedPreferences.getInstance();

    List<String> jsonScores = scores.map((score) => jsonEncode(score)).toList();

    localStorage.setStringList(scoresKey, jsonScores);
  }
}
