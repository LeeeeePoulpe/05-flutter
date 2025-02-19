import 'package:flutter/material.dart';
import 'package:quiz/widgets/questions_summary/summary_item.dart';

// Widget pour afficher la liste des résultats à toutes les questions
class QuestionsSummary extends StatelessWidget {
  // Les résultats du Quiz
  final List<Map<String, Object>> summaryData;

  // Constructeur
  const QuestionsSummary(this.summaryData, {super.key});

  // Construction de l'UI du Widget QuestionsSummary
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
