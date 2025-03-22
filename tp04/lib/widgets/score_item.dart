import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/modele/score.dart';
import 'package:tp02/provider/score_provider.dart';

class ScoreItem extends ConsumerWidget {
  final String id;
  final bool isHighlighted;
  final int rank;

  const ScoreItem(
    this.id, {
    this.isHighlighted = false,
    this.rank = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Score score = ref.watch(scoreProvider(id));

    // Couleurs basées sur vos images
    final textColor = Color(0xFF1A1523);
    final backgroundColor = Colors.white;
    final borderColor = isHighlighted
        ? Color(0xFFFFC107) // Ambre pour le top score
        : Colors.grey.shade200;
    final scoreBackgroundColor = Colors.grey.shade100;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor,
          width: isHighlighted ? 2 : 1,
        ),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Entête avec nom et rang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nom du joueur avec badge si premier
                Row(
                  children: [
                    if (isHighlighted)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xFFFFC107), width: 2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Color(0xFFFFC107),
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Top',
                              style: TextStyle(
                                color: Color(0xFFFFC107),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      score.playerName.isEmpty ? 'Anonyme' : score.playerName,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                // Rang
                if (rank > 0) _buildRankBadge(rank),
              ],
            ),

            SizedBox(height: 16),

            // Score
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: scoreBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${score.score} points',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Détails
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(width: 6),
                    Text(
                      score.formattedDate,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                // Temps
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '${score.chrono.toStringAsFixed(1)}s',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                // Difficulté
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    score.difficulty,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    Color badgeColor;

    if (rank == 1) {
      badgeColor = Color(0xFFFFC107); // Or pour le premier
    } else if (rank == 2) {
      badgeColor = Color(0xFFAAAAAA); // Argent pour le deuxième
    } else if (rank == 3) {
      badgeColor = Color(0xFFCD7F32); // Bronze pour le troisième
    } else {
      badgeColor = Colors.black; // Gris pour les autres
    }

    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: badgeColor,
          width: 2,
        ),
      ),
      child: Text(
        '#$rank',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: badgeColor,
          fontSize: 14,
        ),
      ),
    );
  }

}
