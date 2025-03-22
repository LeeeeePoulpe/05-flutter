import 'package:tp02/modele/score.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/provider/scores_list_provider.dart';

final scoreProvider = Provider.family<Score, String>((ref, scoreId) {
  final scores = ref.watch(scoresListProvider).scores;
  return scores.firstWhere((score) => score.id == scoreId);
});