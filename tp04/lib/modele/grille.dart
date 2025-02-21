import 'dart:math';
import 'package:tp02/modele/case.dart';
import 'package:tp02/modele/coup.dart';

/// [Grille] de démineur
class Grille {
  /// Dimension de la grille carrée : [taille]x[taille]
  final int taille;

  /// Nombre de mines présentes dans la grille
  final int nbMines;

  /// Attribut privé (_), liste composée [taille] listes de chacune [taille] cases
  final List<List<Case>> _grille = [];

  final Stopwatch stopwatch = Stopwatch();

  /// Construit une [Grille] comportant [taille] lignes, [taille] colonnes et [nbMines] mines
  Grille({required this.taille, required this.nbMines}) {
    int nbCasesACreer = nbCases; // Le nombre de cases qu'il reste à créer
    int nbMinesAPoser = nbMines; // Le nombre de mines qu'il reste à poser
    Random generateur = Random(); // Générateur de nombres aléatoires
    // Pour chaque ligne de la grille
    for (int lig = 0; lig < taille; lig++) {
      // On va ajouter à la grille une nouvelle Ligne (liste de 'cases')
      List<Case> uneLigne = []; //
      for (int col = 0; col < taille; col++) {
        // S'il reste nBMinesAPoser dans nbCasesACreer, la probabilité de miner est nbMinesAPoser/nbCasesACreer
        // Donc on tire un nombre aléatoire a dans [1..nbCasesACreer] et on pose une mine si a <= nbMinesAposer
        bool isMinee = generateur.nextInt(nbCasesACreer) < nbMinesAPoser;
        if (isMinee) nbMinesAPoser--; // une mine de moins à poser
        uneLigne.add(Case(isMinee)); // On ajoute une nouvelle case à la ligne
        nbCasesACreer--; // Une case de moins à créer
      }
      // On ajoute la nouvelle ligne à la grille
      _grille.add(uneLigne);
    }
    // Les cases étant créées et les mines posées, on calcule pour chaque case le 'nombre de mines autour'
    calculeNbMinesAutour();
    stopwatch.start(); // Démarrer le chronomètre à la création de la grille
  }

  /// Getter qui retourne le nombre de cases
  int get nbCases => taille * taille;

  /// Retourne la [Case] de la [Grille] située à [coord]
  Case getCase(Coordonnees coord) {
    return _grille[coord.ligne][coord.colonne];
  }

  /// Retourne la liste des [Coordonnees] des voisines de la case située à [coord]
  List<Coordonnees> getVoisines(Coordonnees coord) {
    List<Coordonnees> listeVoisines = [];

    for (int ligne = coord.ligne - 1; ligne <= coord.ligne + 1; ligne++) {
      for (int colonne = coord.colonne - 1;
          colonne <= coord.colonne + 1;
          colonne++) {
        if (ligne >= 0 && ligne < taille && colonne >= 0 && colonne < taille) {
          if (ligne != coord.ligne || colonne != coord.colonne) {
            listeVoisines.add((colonne: colonne, ligne: ligne));
          }
        }
      }
    }

    return listeVoisines;
  }

  /// Assigne à chaque [Case] le nombre de mines présentes dans ses voisines
  void calculeNbMinesAutour() {
    for (int lig = 0; lig < taille; lig++) {
      for (int col = 0; col < taille; col++) {
        int nbMines = 0;
        final coord = (ligne: lig, colonne: col); // Création du record

        // Parcourir toutes les cases voisines
        for (final voisine in getVoisines(coord)) {
          if (getCase(voisine).minee) {
            nbMines++;
          }
        }

        _grille[lig][col].nbMinesAutour = nbMines;
      }
    }
  }

  /// - Découvre récursivement toutes les cases voisines d'une case située à [coord]
  /// - La case située à [coord] doit être découverte
  void decouvrirVoisines(Coordonnees coord) {
    for (final voisin in getVoisines(coord)) {
      Case c = getCase(voisin);
      if (c.etat == Etat.couverte) {
        c.decouvrir();
        if (!c.minee && c.nbMinesAutour == 0) {
          decouvrirVoisines(voisin);
        }
      }
    }
  }

  /// Met à jour la Grille en fonction du [coup] joué
  void mettreAJour(Coup coup) {
    final maCase = getCase(coup.coordonnees);

    switch (coup.action) {
      case Action.decouvrir:
        maCase.decouvrir();
        // Si la case n'est pas minée et n'a pas de mines autour, on découvre les voisines
        if (!maCase.minee && maCase.nbMinesAutour == 0) {
          decouvrirVoisines(coup.coordonnees);
        }
        break;
      case Action.marquer:
        maCase.inverserMarque();
        break;
    }
  }

  /// Renvoie vrai si [Grille] ne comporte que des cases soit minées soit découvertes (mais pas les 2)
  bool isGagnee() {
    for (final ligne in _grille) {
      for (final maCase in ligne) {
        if (maCase.minee && maCase.etat == Etat.decouverte) {
          return false;
        } else if (!maCase.minee && maCase.etat != Etat.decouverte) {
          return false;
        }
      }
    }
    return true;
  }

  /// Renvoie vrai si [Grille] comporte au moins une case minée et découverte
  bool isPerdue() {
    for (final ligne in _grille) {
      for (final maCase in ligne) {
        if (maCase.minee && maCase.etat == Etat.decouverte) {
          return true;
        }
      }
    }
    return false;
  }

  /// Renvoie vrai si la partie est finie, gagnée ou perdue
  bool isFinie() {
    bool finie = isGagnee() || isPerdue();
    if (finie) {
      stopwatch.stop(); // Arrêter le chronomètre quand la partie est finie
    }
    return finie;
  }

  /// Retourne le temps écoulé en secondes
  int get tempsEcoule => stopwatch.elapsed.inSeconds;
}
