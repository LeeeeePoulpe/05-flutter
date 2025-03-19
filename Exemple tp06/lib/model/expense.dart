import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Objet pour formater une date (objet de la classe DateTime) au format FR
final formatterFR = DateFormat("dd/MM/yyyy");
// Objet pour formater une date (objet de la classe DateTime) au format EN
final formatterEN = DateFormat("yyyy-MM-dd");
// Objet pour forger automatiquement un identifiant unique (String)
const uuid = Uuid();
// Type énuméré pour représenter les catégories de dépenses
enum Category { alimentation, loisirs, travail, voyage }

// CLasse pour représenter une dépense
class Expense {
  // Constructeur avec liste d'initialisation (:)
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id; // Identifiant unique (uuid)
  final String title; 
  final double amount;
  final DateTime date;
  final Category category;

  // Getter qui permet de fournir un attribut "calculé" (ici la date formattée en String)
  // Pas besoin de parenthèse pour invoquer cette méthode (getter), on écrira depense.formattedDate
  String get formattedDate {
    return formatterFR.format(date);
  }

  // Construit un objet Expense à partir d'une Map Json (utilisable par jsonDecode)
  Expense.fromJson(Map<String, dynamic> json) 
  : id=json['id'],
    title=json['title'],
    amount=json['amount'],
    date=DateTime.parse(json['date']),
    category=Category.values.byName(json['category']);

  // Convertit un objet Expense en Map Json (utilisable par jsonEncode)
  Map<String,dynamic> toJson() => {
    'id':id, 
    'title':title, 
    'amount' :amount, 
    'date': formatterEN.format(date), 
    'category' : category.toString().split('.')[1]
  };
}
