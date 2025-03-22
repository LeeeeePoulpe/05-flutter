// Dans un fichier family_details_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/modele/score.dart';
import 'package:tp02/provider/family_provider.dart';
import 'package:tp02/provider/scores_list_provider.dart';

class FamilyDetailsDialog extends ConsumerWidget {
  final String id;

  const FamilyDetailsDialog({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Score? playerScore = ref.watch(familyProvider(id));

    // Couleurs basées sur le style global
    final textColor = Color(0xFF1A1523);
    final backgroundColor = Colors.white;
    final borderColor = Colors.grey.shade200;
    final accentColor = Color(0xFF6E56CF);
    final scoreBackgroundColor = Colors.grey.shade50;
    final dangerColor = Color(0xFFF43F5E); // Rouge pour le bouton supprimer

    // Calcul de la largeur optimale pour les boîtes de dialogue
    final screenWidth = MediaQuery.of(context).size.width;
    final smallDialogWidth = screenWidth > 500 ? 400.0 : screenWidth * 0.85;
    final largeDialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.9;

    if (playerScore == null) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: smallDialogWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joueur non trouvé',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Aucun score trouvé pour ce joueur',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Fermer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: largeDialogWidth,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec avatar et nom
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        playerScore.playerName.isNotEmpty
                            ? playerScore.playerName[0].toUpperCase()
                            : 'A',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playerScore.playerName.isEmpty
                              ? 'Anonyme'
                              : playerScore.playerName,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Détails du score',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close,
                        color: Colors.grey.shade600, size: 20),
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Score
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: scoreBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFC107).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.emoji_events_outlined,
                            color: Color(0xFFFFC107),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Score',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${playerScore.score} points',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Titre de la section détails
              Text(
                'Informations',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 12),

              // Détails
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date',
                      value: playerScore.formattedDate,
                      textColor: textColor,
                    ),
                    SizedBox(height: 12),
                    Divider(color: borderColor, height: 1),
                    SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.timer_outlined,
                      label: 'Temps',
                      value: '${playerScore.chrono.toStringAsFixed(1)}s',
                      textColor: textColor,
                    ),
                    SizedBox(height: 12),
                    Divider(color: borderColor, height: 1),
                    SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.speed_outlined,
                      label: 'Difficulté',
                      value: playerScore.difficulty,
                      textColor: textColor,
                      valueColor: _getDifficultyColor(playerScore.difficulty),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Boutons d'action
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Bouton supprimer
                  OutlinedButton.icon(
                    onPressed: () {
                      // Afficher une boîte de dialogue de confirmation
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            // Définir la largeur maximale du dialog
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: smallDialogWidth,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Titre
                                    Text(
                                      'Confirmer la suppression',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -0.5,
                                      ),
                                    ),

                                    SizedBox(height: 16),

                                    // Message
                                    Text(
                                      'Êtes-vous sûr de vouloir supprimer le score de ${playerScore.playerName}?',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),

                                    SizedBox(height: 32),

                                    // Boutons d'action
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Bouton Annuler
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  Colors.grey.shade700,
                                              side: BorderSide(
                                                  color: Colors.grey.shade300),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Text(
                                              'Annuler',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 12),

                                        // Bouton Supprimer
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              ref
                                                  .read(scoresListProvider
                                                      .notifier)
                                                  .removeScore(playerScore.id);
                                              Navigator.of(context)
                                                  .pop(); // Fermer la boîte de dialogue de confirmation
                                              Navigator.of(context)
                                                  .pop(); // Fermer la boîte de dialogue des détails
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: dangerColor,
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            icon: Icon(Icons.delete_outline,
                                                size: 18),
                                            label: Text(
                                              'Supprimer',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete_outline, size: 18),
                    label: Text('Supprimer'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: dangerColor,
                      side: BorderSide(color: dangerColor.withOpacity(0.5)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Bouton fermer
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Fermer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 16,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
