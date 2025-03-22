import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur_follmih/modele/score.dart';
import 'package:demineur_follmih/provider/scores_list_provider.dart';

final sortedScroredListProvider = Provider<List<Score>>((ref) {
  final scores = ref.watch(scoresListProvider).scores.map((e) => e).toList();
  scores.sort((e1, e2) => -e1.score.compareTo(e2.score));
  return scores;
});
