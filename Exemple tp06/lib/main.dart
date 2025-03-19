// Application de suivi des dépenses, adaptée du code de Maximilian Schwarzmüller
// https://www.udemy.com/user/maximilian-schwarzmuller/
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:expense_tracker/screen/expenses_screeen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Programme principal qui exécute une "MaterialApp"
//  avec des thèmes personnalisés (voir ci-dessous)
void main() {
  runApp(ProviderScope(
    // Cette application utilise RiverPod
    child: MaterialApp(
      debugShowCheckedModeBanner: false, // pour masquer la bannière Debug
      localizationsDelegates: GlobalMaterialLocalizations
          .delegates, // Pour gérer l'i18n (ici dates en français)
      supportedLocales: const [Locale('fr')], // On définit la locale à fr
      theme: appTheme, // On utilise un thème standard personnalisé
      darkTheme: appDarkTheme, // On utilise un thème sombre personnalisé
      themeMode: ThemeMode.system, // Thème choisi selon la préf. système
      home: const ExpensesScreen(), // On affiche le Widget ExpensesScreen
    ),
  ));
}

// Jeu de couleur produit à partir d'une couleur de base (vert foncé)
// Utilisé pour le formulaire de saisie d'une dépense
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

// Theme sombre de l'application
var appDarkTheme = ThemeData.dark().copyWith(
  colorScheme: kDarkColorScheme,
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
    ),
  ),
);

// Jeu de couleur produit à partir d'une couleur de base (violet)
// Utilisé pour le Widget principal
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

// Theme clair de l'application
var appTheme = ThemeData().copyWith(
  colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 16,
        ),
      ),
);
