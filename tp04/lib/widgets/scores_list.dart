import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/modele/score.dart';
import 'package:tp02/provider/scores_list_provider.dart';
import 'package:tp02/provider/sorted_score_list_provider.dart';
import 'package:tp02/widgets/score_item.dart';

class ScoresList extends ConsumerWidget {
  const ScoresList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Score> scores = ref.watch(sortedScroredListProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: scores.length,
      itemBuilder: (ctx, index) {
        final isFirst = index == 0;

        return Dismissible(
          key: ValueKey(scores[index]),
          // méthode pour supprimer un score
          onDismissed: (_) {
            ref.watch(scoresListProvider.notifier).removeScore(scores[index].id);
          },
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFFEE4E2),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete_outline,
              color: Color(0xFFD92D20),
            ),
          ),
          direction: DismissDirection.endToStart,
          child: ScoreItem(
            scores[index].id,
            isHighlighted: isFirst,
            rank: index + 1,
          ),
        );
      },
    );
  }
}
