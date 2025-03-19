import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/provider/expenses_provider.dart';
import 'package:expense_tracker/model/expense.dart';

// Provider qui fournit la liste des dépenses triées par date décroissante
// Ce provider est abonné à expensesProvider
// Il est donc notifié lorsque l'état de expensesProvider est modifié
// et il notifie alors ses propres abonnés
final sortedExpensesProvider = Provider<List<Expense>>((ref) {
  final expenses = ref.watch(expensesProvider).expenses.map((e)=>e).toList();
  expenses.sort((e1,e2) => -e1.date.compareTo(e2.date));
  return expenses;
});