import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur_follmih/modele/score.dart';
import 'package:demineur_follmih/provider/score_provider.dart';
import 'package:demineur_follmih/widgets/familyDetailsDialog.dart';

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

    // Couleurs basées sur le style global
    final textColor = Color(0xFF1A1523);
    final backgroundColor = Colors.white;
    final borderColor = isHighlighted
        ? Color(0xFFFFC107) // Ambre pour le top score
        : Colors.grey.shade200;
    final scoreBackgroundColor = Colors.grey.shade50;
    final accentColor = Color(0xFF6E56CF);

    // Couleur basée sur la difficulté
    final difficultyColor = _getDifficultyColor(score.difficulty);

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
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => FamilyDetailsDialog(
              id: score.id,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
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
                  Expanded(
                    child: Row(
                      children: [
                        // Avatar du joueur
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? Color(0xFFFFC107).withOpacity(0.1)
                                : accentColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: isHighlighted
                              ? Icon(
                                  Icons.emoji_events,
                                  color: Color(0xFFFFC107),
                                  size: 20,
                                )
                              : Center(
                                  child: Text(
                                    score.playerName.isNotEmpty
                                        ? score.playerName[0].toUpperCase()
                                        : 'A',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (isHighlighted)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFFFFC107).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'Top',
                                        style: TextStyle(
                                          color: Color(0xFFFFC107),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  Flexible(
                                    child: Text(
                                      score.playerName.isEmpty
                                          ? 'Anonyme'
                                          : score.playerName,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                score.formattedDate,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Rang
                  if (rank > 0) _buildRankBadge(rank),
                ],
              ),

              SizedBox(height: 16),

              // Score
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: scoreBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.stars,
                            color: accentColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Score',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${score.score} points',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                  // Temps
                  _buildInfoChip(
                    icon: Icons.timer_outlined,
                    label: '${score.chrono.toStringAsFixed(1)}s',
                    color: Colors.grey.shade600,
                  ),

                  // Difficulté
                  _buildInfoChip(
                    icon: Icons.speed_outlined,
                    label: score.difficulty,
                    color: difficultyColor,
                    backgroundColor: difficultyColor.withOpacity(0.1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    Color badgeColor;
    Color textColor;
    Color backgroundColor;

    if (rank == 1) {
      badgeColor = Color(0xFFFFC107); // Or pour le premier
      textColor = Color(0xFF1A1523);
      backgroundColor = badgeColor.withOpacity(0.1);
    } else if (rank == 2) {
      badgeColor = Color(0xFFAAAAAA); // Argent pour le deuxième
      textColor = Color(0xFF1A1523);
      backgroundColor = badgeColor.withOpacity(0.1);
    } else if (rank == 3) {
      badgeColor = Color(0xFFCD7F32); // Bronze pour le troisième
      textColor = Color(0xFF1A1523);
      backgroundColor = badgeColor.withOpacity(0.1);
    } else {
      badgeColor = Colors.grey.shade400;
      textColor = Colors.grey.shade700;
      backgroundColor = Colors.grey.shade100;
    }

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: badgeColor,
          width: 1.5,
        ),
      ),
      child: Text(
        '#$rank',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
    Color? backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return Color(0xFF4ADE80); // Vert
      case 'moyen':
        return Color(0xFFFACC15); // Jaune
      case 'difficile':
        return Color(0xFFF43F5E); // Rouge
      default:
        return Color(0xFF1A1523); // Couleur de texte par défaut
    }
  }
}
