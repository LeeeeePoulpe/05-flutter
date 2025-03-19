import 'package:flutter/material.dart';
import 'package:tp02/screens/game_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _cheatModeEnabled = false; // Pour activer/désactiver le bouton de triche

  @override
  void initState() {
    _nameController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Couleurs inspirées de Shadcn
    final backgroundColor = Colors.grey.shade50;
    final textColor = Color(0xFF1A1523); // Presque noir
    final borderColor = Colors.grey.shade200;
    final secondaryTextColor = Colors.grey.shade600;
    final accentColor = Color(0xFF6E56CF);

    // Couleurs pour les niveaux de difficulté
    final easyColor = Color(0xFF4ADE80); // Vert
    final mediumColor = Color(0xFFFACC15); // Jaune
    final hardColor = Color(0xFFF43F5E); // Rouge

    // Calculer la largeur maximale pour les écrans larges
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final contentWidth = isLargeScreen ? 500.0 : screenWidth;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: contentWidth,
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.grid_goldenratio,
                            size: 48,
                            color: textColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Démineur',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Section nom du joueur
                    Text(
                      'Nom du joueur',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Entrez votre nom",
                          hintStyle: TextStyle(color: secondaryTextColor),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person_outline,
                              color: secondaryTextColor),
                        ),
                        style: TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer un nom de joueur";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Section difficulté
                    Text(
                      'Niveau de difficulté',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Boutons de difficulté
                    _buildDifficultyButton(
                      label: 'Facile',
                      gridSize: '8×8',
                      mineCount: 10,
                      color: easyColor,
                      onPressed: () => _startGame(8, 10),
                      textColor: textColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 12),
                    _buildDifficultyButton(
                      label: 'Moyen',
                      gridSize: '12×12',
                      mineCount: 20,
                      color: mediumColor,
                      onPressed: () => _startGame(12, 20),
                      textColor: textColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 12),
                    _buildDifficultyButton(
                      label: 'Difficile',
                      gridSize: '16×16',
                      mineCount: 40,
                      color: hardColor,
                      onPressed: () => _startGame(16, 40),
                      textColor: textColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.auto_fix_high,
                                color: _cheatModeEnabled
                                    ? accentColor
                                    : secondaryTextColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mode Triche',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Activer le bouton de triche',
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Switch(
                            value: _cheatModeEnabled,
                            onChanged: (value) {
                              setState(() {
                                _cheatModeEnabled = value;
                              });
                            },
                            activeColor: Colors.white,
                            activeTrackColor: accentColor.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton({
    required String label,
    required String gridSize,
    required int mineCount,
    required Color color,
    required VoidCallback onPressed,
    required Color textColor,
    required Color borderColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Indicateur de couleur
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            // Contenu principal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Icône et texte pour la taille de la grille
                      Icon(
                        Icons.grid_view,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        gridSize,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Icône et texte pour le nombre de mines
                      Icon(
                        Icons.dangerous,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "$mineCount mines",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Flèche
            Icon(
              Icons.arrow_forward,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _startGame(int taille, int nbMines) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GameScreen(
            tailleFromStartScreen: taille,
            nbMinesFromStartScreen: nbMines,
            playerName: _nameController.text,
            cheatModeEnabled: _cheatModeEnabled,
          ),
        ),
      );
    }
  }
}
