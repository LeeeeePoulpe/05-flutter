import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/modele/score.dart';
import 'package:tp02/provider/scores_list_provider.dart';

final familyProvider = Provider.family<Score?, String>((ref, id) {
  final scoresList = ref.watch(scoresListProvider);

  try {
    return scoresList.scores.firstWhere(
        (score) => score.id == id);
  } catch (e) {
    return null;
  }
});
