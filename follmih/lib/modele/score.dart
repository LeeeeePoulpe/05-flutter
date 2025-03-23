import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatterFR = DateFormat("dd/MM/yyyy");

const uuid = Uuid();

class Score {
  Score({
    required this.playerName,
    required this.score,
    required this.difficulty,
    required this.chrono,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String playerName;
  final int score;
  final String difficulty;
  final double chrono;
  final DateTime date;

  String get formattedDate {
    return formatterFR.format(date);
  }

  Score.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      playerName = json['playerName'],
      score = json['score'],
      difficulty = json['difficulty'],
      chrono = json['chrono'],
      date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'playerName': playerName,
    'score': score,
    'difficulty': difficulty,
    'chrono': chrono,
    'date': formatterFR.format(date),
  };
}
