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
    final textColor = Color(0xFF1A1523);

    if (scores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 16),
            Text(
              'Aucun score enregistré',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Jouez une partie pour voir apparaître votre score ici',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête de la liste
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Classement',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${scores.length} joueur${scores.length > 1 ? 's' : ''}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Astuce pour le swipe
        if (scores.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF9F5FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE9D7FE)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.swipe_left,
                    size: 16,
                    color: Color(0xFF6E56CF),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Glissez vers la gauche pour supprimer un score',
                      style: TextStyle(
                        color: Color(0xFF6E56CF),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Liste des scores
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: scores.length,
            itemBuilder: (ctx, index) {
              final isFirst = index == 0;
              final score = scores[index];

              return Dismissible(
                key: ValueKey(score),
                onDismissed: (_) {
                  ref.read(scoresListProvider.notifier).removeScore(score.id);

                  // Afficher un snackbar de confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Score de ${score.playerName} supprimé'),
                      backgroundColor: Color(0xFF1A1523),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.all(8),
                    ),
                  );
                },
                confirmDismiss: (direction) async {
                  // Demander confirmation avant de supprimer
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final textColor = Color(0xFF1A1523);
                      final dangerColor = Color(0xFFF43F5E);
                      final screenWidth = MediaQuery.of(context).size.width;

                      // Calculer la largeur optimale pour la boîte de dialogue
                      final dialogWidth =
                          screenWidth > 500 ? 400.0 : screenWidth * 0.85;

                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        // Définir la largeur maximale du dialog
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: dialogWidth,
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
                                  'Êtes-vous sûr de vouloir supprimer le score de ${score.playerName}?',
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
                                            Navigator.of(context).pop(false),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.grey.shade700,
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
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
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
                background: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEE4E2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Color(0xFFD92D20),
                        size: 24,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Supprimer',
                        style: TextStyle(
                          color: Color(0xFFD92D20),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                direction: DismissDirection.endToStart,
                child: ScoreItem(
                  score.id,
                  isHighlighted: isFirst,
                  rank: index + 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
