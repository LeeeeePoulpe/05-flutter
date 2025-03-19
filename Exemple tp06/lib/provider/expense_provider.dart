import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/provider/expenses_provider.dart';
import 'package:expense_tracker/model/expense.dart';

// Provider 'paramétré' (Family) pour accéder à une dépense parmi les dépenses fournies par ExpensesProvider
// Ce provider est donc abonné à ExpensesProvider et sera notifié quand celui-ci change d'état
final expenseProvider = Provider.family<Expense, String>((ref, expenseId) {
  // En faisant un "watch" sur expensesProvide, on s'abonne à ce Provider
  final expenses = ref.watch(expensesProvider).expenses;
  return expenses.firstWhere((expense) => expense.id == expenseId);
});
