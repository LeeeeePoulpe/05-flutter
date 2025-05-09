import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demineur_follmih/provider/sorted_score_list_provider.dart';
import 'package:demineur_follmih/widgets/scores_list.dart';

class ScoresScreen extends ConsumerStatefulWidget {
  const ScoresScreen({super.key});

  @override
  ConsumerState<ScoresScreen> createState() {
    return ScoresScreenState();
  }
}

class ScoresScreenState extends ConsumerState<ScoresScreen> {
  @override
  Widget build(BuildContext context) {
    // Couleurs inspirées de Shadcn
    final backgroundColor = Colors.grey.shade50;
    final textColor = Color(0xFF1A1523); // Presque noir
    final borderColor = Colors.grey.shade200;
    final secondaryTextColor = Colors.grey.shade600;

    final bool isNotEmpty = ref.watch(sortedScroredListProvider).isNotEmpty;

    // Calculer la largeur maximale pour les écrans larges
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final contentWidth = isLargeScreen ? 500.0 : screenWidth;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Scores',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: textColor,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: contentWidth,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Liste des scores ou message
                Expanded(
                  child: isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const ScoresList(),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.emoji_events_outlined,
                                size: 64,
                                color: secondaryTextColor.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aucun score enregistré',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Jouez une partie pour voir apparaître vos scores ici',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
