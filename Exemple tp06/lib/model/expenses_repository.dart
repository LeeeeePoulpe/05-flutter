import 'dart:convert';
import 'package:expense_tracker/model/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe pour gérer une liste de dépenses
// que l'on peut faire persister dans le local storage
class ExpensesRepository {
  List<Expense> expenses; // Le tableau des dépenses
  static const expensesKey =
      'r605_expenses_list'; // La clé pour le local storage

  List<Expense> get list => expenses;
  // Constructeur pour fabriquer un ExpenseRepository à partir d'une liste de dépenses
  ExpensesRepository(this.expenses);
    // Constructeur pour fabriquer un ExpenseRepository vide
  ExpensesRepository.empty() : expenses=[];

  // Charge la liste des dépenses depuis le local storage
  Future<void> load() async {
    final localStorage = await SharedPreferences.getInstance();
    // On charge depuis le local storage le tableau des dépenses au format Json
    List<String> jsonExpenses = localStorage.getStringList(expensesKey) ?? [];
    // Et on décode le Json de chaque dépense
    expenses = jsonExpenses
        .map((jsonExpense) => Expense.fromJson(jsonDecode(jsonExpense)))
        .toList();
  }

  // Sauvegarde la liste des dépenses dans le local storage
  Future<void> save() async {
    final localStorage = await SharedPreferences.getInstance();
    List<String> jsonExpenses =
        expenses.map((expense) => jsonEncode(expense)).toList();
    localStorage.setStringList(expensesKey, jsonExpenses);
  }
}
