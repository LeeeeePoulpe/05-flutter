import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/widgets/expense_form.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/provider/expenses_provider.dart';
import 'package:expense_tracker/model/expense.dart';

// Widget principal qui affiche l'écran (unique) de l'application
// Ce widget devient un consommateur de providers riverpod (ConsumerStatefulWidget)
class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});
  @override
  ConsumerState<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

// L'état associé au Widget ExpensesScreen
class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  // Méthode appelée pour ouvrir la modale contenant le formulaire de saisie
  void _openAddExpenseModale() {
    // On affiche une modale qui contient le formulaire construit dans ExpenseForm
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, // context est un attribut disponible dans l'état
      builder: (context) => const ExpenseForm(),
    );
  }

  // Méthode transmise à ExpensesList pour supprimer une dépense
  // En cas de suppression (par balayage), une SnackBar est affichée pendant 3s
  // Elle offre la possibilité d'annuler la suppression
  void _removeExpense(Expense expense) {
    // On supprime la dépense (modification d'état global)
    ref.watch(expensesProvider.notifier).removeExpense(expense);
    // On efface les éventuelles SnackBars affichées
    ScaffoldMessenger.of(context).clearSnackBars();
    // On montre la SnackBar qui informe de la suppression et permet de l'annuler
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Dépense supprimée.'),
        action: SnackBarAction(
          label: 'Annuler',
          onPressed: () {
            // Si annulation, on rajoute la dépense qui venait d'être supprimée
            ref.watch(expensesProvider.notifier).addExpense(expense);
          },
        ),
      ),
    );
  }

  // Construit l'UI du Widget ExpensesScreen
  @override
  Widget build(BuildContext context) {
    // On consomme expensesProvider uniquement pour savoir s'il y a des dépenses
    final bool isNotEmpty = ref.watch(expensesProvider).expenses.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Dépenses'),
        actions: [
          IconButton(
            // Le bouton qui permet d'afficher le formulaire d'ajout
            onPressed: _openAddExpenseModale,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isNotEmpty
          ? Expanded(
              child: ExpensesList(onRemoveExpense: _removeExpense),
            )
          : const Center(
              child: Text(
                textAlign: TextAlign.center,
                'Aucune dépense trouvée.\n\nVous pouvez en ajouter avec le bouton +',
              ),
            ),
    );
  }
}
