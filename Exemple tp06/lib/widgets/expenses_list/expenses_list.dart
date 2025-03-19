import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/provider/sorted_expenses_provider.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/model/expense.dart';

// Widget pour afficher une liste déroulante de dépenses (ExpenseItem), triée
// Utilise un widget Listview (https://api.flutter.dev/flutter/widgets/ListView-class.html)
// Chaque élément pourra être supprimé (Dismissible) par un balayage
class ExpensesList extends ConsumerWidget {
  // Méthode transmise par ExpensesScreen pour pouvoir supprimer une dépense
  //  et afficher une snackbar d'annulation
  final void Function(Expense expense) onRemoveExpense;

  // Constructeur
  const ExpensesList({super.key, required this.onRemoveExpense});

  // Construire l'UI du Widget ExpensesList
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On consomme sorteExpensesProvider pour récupérer la liste triée des dépenses
    final List<Expense> expenses = ref.watch(sortedExpensesProvider);
    return ListView.builder(
      // On précise le nombre d'éléments dans la liste
      itemCount: expenses.length,
      // Chaque élément de la liste est ici enveloppé dans un Widget Dismissible
      // (https://api.flutter.dev/flutter/widgets/Dismissible-class.html)
      // Ce Widget permet de réaliser une action lorsque son contenu est balayé
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index].id,
        ),
      ),
    );
  }
}
