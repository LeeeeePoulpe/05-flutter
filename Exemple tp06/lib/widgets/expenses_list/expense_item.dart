import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Map pour associer une catégorie à une icone
const categoryIcons = {
  Category.alimentation: Icons.lunch_dining,
  Category.voyage: Icons.flight_takeoff,
  Category.loisirs: Icons.movie,
  Category.travail: Icons.work,
};

// Widget pour afficher un élément dépense dans la liste des dépenses (ExpensesList)
class ExpenseItem extends ConsumerWidget {

  // L'id de la dépense affichée dans le Widget
  final String expenseId;

  // Constructeur
  const ExpenseItem(this.expenseId, {super.key});

  // Construit l'UI du widget ExpenseItem
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On recupère la dépense, grâce à son id, auprès du provider expenseProviderFamily
    Expense expense = ref.watch(expenseProvider(expenseId));
    // Et on fabrique une Card pour afficher cette dépense
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${expense.amount.toStringAsFixed(2)} €',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
