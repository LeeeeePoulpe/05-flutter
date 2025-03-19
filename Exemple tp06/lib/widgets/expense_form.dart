import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/provider/expenses_provider.dart';

// Le formulaire pour saisir une nouvelle dépense
// Ce widget va modifier l'état d'un provider riverpod (ConsumerStatefulWidget)
class ExpenseForm extends ConsumerStatefulWidget {
  // Constructeur
  const ExpenseForm({super.key});
  // Création de l'état associé au Stateful Widget ExpenseForm
  @override
  ConsumerState<ExpenseForm> createState() {
    return _ExpenseFormState();
  }
}

// L'état associé à ExpenseForm
class _ExpenseFormState extends ConsumerState<ExpenseForm> {
  // Contrôleur du champ texte "titre". Son attribut text contient le texte saisi
  final _titleController = TextEditingController();
  // Contrôleur du champ texte "montant". Son attribut text contient le texte saisi
  final _amountController = TextEditingController();
  // La date affichée dans le formulaire (modifiée par un DatePicker)
  DateTime? _selectedDate;
  // La catégorie saisie dans le formulaire (modifiée par un DropdownButton)
  Category _selectedCategory = Category.values[0];

  // Méthode automatiquement appelée quand le widget sera supprimé (fermeture du formulaire)
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Méthode asynchrone qui affiche un DatePicker pour saisir une date
  void _displayDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    // On attend le résultat de la méthode asynchrone showDatePicker
    final selectedDate = await showDatePicker(
      context: context,
      helpText: "Date Dépense ?",
      locale: const Locale("fr", "FR"),
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate==null) _displayDatePicker();
    // On modifie l'état du widget ExpenseForm
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  // Méthode qui affiche une alerte pour prévenir que les données saisies sont invalides
  void _showInvalidDataAlert() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Saisie Non Valide'),
            content: const Text(
              'Vous devez saisir un titre, un montant, une date et une catégorie.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // on dépile le dialogue de l'UI
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ),
    );
  }

  // Validation des données du formulaire et soumission si données correctes
  void _submitExpenseData() {
    // On vérifie que le montant est bien un entier >=0
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    // Si le titre est vide, le montant non correct ou la date vide
    //  on montre un dialogue pour demander à l'utilisateur de corriger
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showInvalidDataAlert();
    } else {
      // les données du formulaire sont valides : on ajoute une dépense à expensesProvider
      ref.watch(expensesProvider.notifier).addExpense(
        Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory,
        ),
      );
      Navigator.of(context).pop(); // On dépile la modale
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Titre')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: ' €',
                    label: Text('Montant'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Saisir la date'
                          : formatterFR.format(_selectedDate!)
                    ),
                    IconButton(
                      onPressed: _displayDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Si annulation, on dépile la modale du formulaire
                },
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData, // Si enregistrer, on valide le formulaire
                child: const Text('Enregister Dépense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
