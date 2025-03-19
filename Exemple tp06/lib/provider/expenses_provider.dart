import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/model/expenses_repository.dart';
import 'package:expense_tracker/model/expense.dart';

// On instancie un objet expensesProvider, de classe StateNotifierProvider<>
// Ce provider sera accessible par tous les widgets (et par d'autres providers)
// Les widgets ou les providers qui feront un "watch" sur ce provider seront notifiés lorsqu'il changera d'état
final expensesProvider =
    StateNotifierProvider<ExpensesRepositoryNotifier, ExpensesRepository>(
        (ref) => ExpensesRepositoryNotifier());

// Classe héritant de StateNotifier pour gèrer un objet PersistentExpenses (liste des dépenses)
// L'attribut state est l'état géré par le StateNotifier, ici ce sera donc un objet ExpensesRepository
// Le StateNotifier doit fournir des méthodes pour modifier son état
class ExpensesRepositoryNotifier extends StateNotifier<ExpensesRepository> {
  // Constructeur du Notifier
  // On appelle le constructeur de la classe mère en lui transmettant l'état (state)
  // Ici l'état est donc un objet de la classe ExpensesRepository
  ExpensesRepositoryNotifier() : super(ExpensesRepository.empty()) {
    // On charge de façon asynchrone le contenu sauvegardé dans le local storage
    // et on crée une nouvelle instance de PersistentExpenses
    // pour que le changement d'état soit notifié aux abonnées
    state.load().whenComplete(() => state=ExpensesRepository(state.expenses)); 
  }

  // Méthode qui ajoute une dépense à l'état du Provider
  // Il faut que l'état soit une nouvelle instance de PersistentExpenses
  // pour que le changement d'état soit notifié aux abonnés
  void addExpense(Expense newExpense) {
    // On ajoute la nouvelle dépense à l'état actuel
    state.expenses.add(newExpense);
    // Et on instancie un nouvel objet ExpensesRepository (clone de l'état actuel)
    // pour que le changement d'état soit bien pris en compte
    state = ExpensesRepository(state.expenses);
    state.save();
  }

  // Méthode qui supprimer une dépense de l'état du Provider
  // Il faut que l'état soit une nouvelle instance de PersistentExpenses
  // pour que le changement d'état soit notifié aux abonnés
  void removeExpense(Expense expenseToRemove) {
    // On supprimer la dépense de l'état actuel
    state.expenses.removeAt(state.expenses
        .indexWhere((expense) => expense.id == expenseToRemove.id));
    // Et on instancie un nouvel objet ExpensesRepository (clone de l'état actuel)
    // pour que le changement d'état soit bien pris en compte
    state = ExpensesRepository(state.expenses);
    state.save();
  }
}
